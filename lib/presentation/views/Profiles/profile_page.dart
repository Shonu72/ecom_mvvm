import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/auth_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/user_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    userController.fetchUsers(id: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // userController.fetchUsers(id: 2 ?? 0);

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
            onPressed: () {
              context.pushNamed('mainpage', pathParameters: {
                'initialIndex': '0',
              });
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Obx(
          () {
            final user = userController.userResponse.value;

            // if (user == null) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.white,
                  title: AppText(
                    text: user?.username ?? 'mor_2314',
                    size: 20,
                    color: Colors.black,
                  ),
                  subtitle: AppText(
                    text: user?.email ?? 'morrison@gmail.com',
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
                  ontap: () {
                    context.push('/orders');
                  },
                ),
                const SizedBox(height: 10),
                ProfileWidget(
                  title: 'Shipping Addresses',
                  subtitle: 'show saved addresses',
                  ontap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ShowAddressScreen(),
                    //   ),
                    // );
                    context.push('/showaddress');
                  },
                ),
                const SizedBox(height: 10),
                ProfileWidget(
                  title: 'Payment Methods',
                  subtitle: 'saved payment system ',
                  ontap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ShowCardScreen(),
                    //   ),
                    // );
                    context.push('/showcardscreen');
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
                ProfileWidget(
                  title: 'LogOut',
                  subtitle: 'you\'ll have to login again',
                  ontap: () {
                    authController.logOut();
                    context.go('/');
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
