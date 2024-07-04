import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/products/home.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, required this.initialIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;

  List pages = [
    const HomePage(),
    const Text('2'),
    const Text('3'),
    const Text('4'),
    const Text('5'),
  ];

  @override
  void initState() {
    // TODO: implement initState
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
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 16,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: const Color.fromARGB(255, 45, 42, 55),
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
                icon: Icon(Icons.shopping_cart_outlined), label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: "Wishlist"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
