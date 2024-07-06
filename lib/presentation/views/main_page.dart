import 'package:animations/animations.dart';
import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/products/home_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/all_prodcts_screen.dart';
import 'package:flutter/material.dart';

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
    const Text('3'),
    const Text('4'),
    const Text('5'),
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
        child: BottomNavigationBar(
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.window_outlined), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: "Wishlist"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
