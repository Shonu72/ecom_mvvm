import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText(text: 'CheckOut', color: primaryColor, size: 20),
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
        body: const Column(
          children: [
            SizedBox(height: 10),
            AppText(
              text: 'Shipping Address',
              color: primaryColor,
              size: 20,
            ),
          ],
        ));
  }
}
