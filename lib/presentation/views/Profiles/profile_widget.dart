import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback ontap;

  const ProfileWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.grey.shade100,
        title: AppText(
          text: title,
          size: 20,
          color: Colors.black,
        ),
        subtitle: AppText(
          text: subtitle,
          size: 16,
          color: Colors.black.withOpacity(0.6),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black38,
          size: 20,
        ),
        onTap: ontap,
      ),
    );
  }
}
