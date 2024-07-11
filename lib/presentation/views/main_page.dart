import 'package:animations/animations.dart';
import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/profile_page.dart';
import 'package:ecom_mvvm/presentation/views/carts/cart_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/home_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/all_prodcts_screen.dart';
import 'package:ecom_mvvm/presentation/views/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, required this.initialIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;

  List<Widget> pages = [
    const HomePage(),
    const AllProductScreen(),
    const CartScreen(),
    WishlistScreen(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[currentIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Obx(
          () => BottomNavigationBar(
            selectedFontSize: 16,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(color: primaryColor),
            unselectedLabelStyle: const TextStyle(color: secondaryColor),
            elevation: 0,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.window_outlined), label: "Categories"),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (cartController.count > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '${cartController.count}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: "Wishlist"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
