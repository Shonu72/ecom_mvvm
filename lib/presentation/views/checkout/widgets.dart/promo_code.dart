import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PromoCodeWidegt extends StatefulWidget {
  const PromoCodeWidegt({super.key});

  @override
  State<PromoCodeWidegt> createState() => _PromoCodeWidegtState();
}

class _PromoCodeWidegtState extends State<PromoCodeWidegt> {
  TextEditingController promoCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: promoCodeController,
            decoration: InputDecoration(
              hintText: 'Enter Promo Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 30,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const AppText(
            text: 'Apply',
            color: Colors.white,
            size: 16,
          ),
        ),
      ],
    );
  }
}
