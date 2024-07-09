import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:flutter/material.dart';

class DeliveryPartners extends StatefulWidget {
  const DeliveryPartners({super.key});

  @override
  DeliveryPartnersState createState() => DeliveryPartnersState();
}

class DeliveryPartnersState extends State<DeliveryPartners> {
  int selectedIndex = 0; // Index of the selected container

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        deliveryPartnersContainer(0, 'assets/fedex.png', '2-3 days'),
        deliveryPartnersContainer(1, 'assets/ekart.png', '3-4 days'),
        deliveryPartnersContainer(2, 'assets/delhivery.png', '3-6 days'),
      ],
    );
  }

  Widget deliveryPartnersContainer(int index, String imagePath, String text) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Card(
        elevation: 2,
        color: Colors.white54,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
