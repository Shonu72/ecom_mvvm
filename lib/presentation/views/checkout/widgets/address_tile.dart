import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/checkout/address.dart';
import 'package:ecom_mvvm/services/database/database_operation.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatefulWidget {
  const AddressTile({super.key});

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  final DatabaseService _databaseService = DatabaseService();
  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    final fetchedAddresses = await _databaseService.getAddresses();
    setState(() {
      addresses = fetchedAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        color: Colors.white54,
        elevation: 2,
        child:
            addresses.isEmpty ? _buildAddAddressOption() : _buildAddressCard(),
      ),
    );
  }

  Widget _buildAddAddressOption() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddressPage(),
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: primaryColor,
                size: 32,
              ),
              SizedBox(height: 10),
              AppText(
                text: "Add Address",
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: addresses.map((address) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: "David Morrison",
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressPage(),
                        ),
                      );
                    },
                    child: const AppText(
                      text: "Change",
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: "${address['addressTitle']}, ${address['city']}",
                    color: Colors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: "${address['locality']}, ${address['state']}",
                    color: Colors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: "${address['pincode']}, ${address['country']}",
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}
