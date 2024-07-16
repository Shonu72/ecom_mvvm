import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/carts/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
          title: const AppText(
            text: 'Cart',
            size: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pushNamed('mainpage', pathParameters: {
                'initialIndex': '0',
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          )),
      body: Obx(
        () {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          } else {
            return ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartController.cartItems.keys.toList()[index];
                final quantity = cartController.cartItems[product];

                return CartTile(
                  product: product,
                  quantity: quantity!,
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text:
                    'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                color: primaryColor,
                fontWeight: FontWeight.w400,
                size: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(primaryColor),
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const CheckoutPage();
                  // }));
                  context.push('/checkout');
                },
                child: const AppText(
                  text: 'Checkout',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
