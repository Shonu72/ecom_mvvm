import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/checkout/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowAddressScreen extends StatelessWidget {
  const ShowAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText(
            text: "Saved Address",
            size: 20,
            color: primaryColor,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              )),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return const AddressTile();
            }));
  }
}
