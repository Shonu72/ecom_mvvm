import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/payment_method.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/profile_widget.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/show_address_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Profile',
          size: 20,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.white,
              title: const AppText(
                text: 'John Dow',
                size: 20,
                color: Colors.black,
              ),
              subtitle: const AppText(
                text: 'abc@test.com',
                size: 16,
                color: Colors.black,
              ),
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg'),
              ),
            ),
            const SizedBox(height: 30),
            ProfileWidget(
              title: 'My Orders',
              subtitle: 'all orders',
              ontap: () {},
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              title: 'Shipping Addresses',
              subtitle: 'show saved addresses',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowAddressScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              title: 'Payment Methods',
              subtitle: 'saved payment system ',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowCardScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              title: 'Promocode & Offers',
              subtitle: 'show latest promo codes',
              ontap: () {},
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              title: 'My Reviews',
              subtitle: 'all reviews',
              ontap: () {},
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              title: 'Settings',
              subtitle: 'Notification, Password..',
              ontap: () {},
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
