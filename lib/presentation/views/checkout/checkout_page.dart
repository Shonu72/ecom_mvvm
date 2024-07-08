import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/carts/cart_screen.dart';
import 'package:ecom_mvvm/presentation/views/checkout/widgets.dart/address_tile.dart';
import 'package:ecom_mvvm/presentation/views/checkout/widgets.dart/delivery_partner_widget.dart';
import 'package:ecom_mvvm/presentation/views/checkout/widgets.dart/promo_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.find<CartController>();
  int shippingCharges = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText(
            text: 'CheckOut',
            color: primaryColor,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const AppText(
                text: 'Shipping Address',
                color: primaryColor,
                size: 16,
              ),
              const AddressTile(),
              const SizedBox(height: 10),
              const AppText(
                text: 'Delivery Partners',
                color: primaryColor,
                size: 16,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  color: Colors.white54,
                  child: SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: const DeliveryPartners(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const PromoCodeWidegt(),
              const SizedBox(height: 30),
              const Divider(
                color: secondaryColor,
                thickness: 0.5,
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    const AppText(
                        text: 'Shipping Charges',
                        color: primaryColor,
                        size: 18),
                    const Spacer(),
                    AppText(
                        text: '₹ $shippingCharges',
                        color: primaryColor,
                        size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    const AppText(
                        text: 'Subtotal', color: primaryColor, size: 18),
                    const Spacer(),
                    AppText(
                        text: '₹ ${cartController.totalPrice}',
                        color: primaryColor,
                        size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: secondaryColor,
                thickness: 0.5,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    const AppText(text: 'Total', color: primaryColor, size: 18),
                    const Spacer(),
                    AppText(
                        text:
                            '₹ ${cartController.totalPrice + shippingCharges}',
                        color: primaryColor,
                        size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: const BorderSide(color: primaryColor),
                  ),
                ),
                child: const AppText(
                  text: 'Pay Amount & Place Order',
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ));
  }
}
