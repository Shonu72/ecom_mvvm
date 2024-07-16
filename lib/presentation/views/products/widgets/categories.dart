import 'package:flutter/material.dart';

class ContainerList extends StatelessWidget {
  const ContainerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CustomContainer(
            backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
            text: 'Electronics',
            onTap: () {
              // Get.toNamed(Routes.categoryScreen, arguments: "electronics");
            },
          ),
          CustomContainer(
            backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
            text: 'jewelery',
            onTap: () {
              // Get.toNamed(Routes.categoryScreen, arguments: "jewelery");
            },
          ),
          CustomContainer(
            backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
            text: 'Men\'s Clothing',
            onTap: () {
              // Get.toNamed(Routes.categoryScreen, arguments: "men\'s clothing");
            },
          ),
          CustomContainer(
            backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
            text: 'Women\'s Clothing',
            onTap: () {
              // Get.toNamed(Routes.categoryScreen,
              //     arguments: "women\'s clothing");
            },
          ),
          // Add more instances of CustomContainer as needed
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final NetworkImage backgroundImage;
  final String text;
  final VoidCallback onTap;

  const CustomContainer(
      {super.key,
      required this.backgroundImage,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 5),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
  });
//
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          _customRadioButton,
        ],
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff0F172A),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}
