import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback ontap;
  ProductTile(
    this.product,
    this.ontap, {
    super.key,
  });
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    int rating = product.rating.rate.toInt();
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: ontap,
                    child: Image.network(
                      product.image,
                      height: 130,
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      )),
                )
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < rating ? starColor : secondaryColor,
                );
              }),
            ),
            Text(
              product.title,
              // "Evening Dress",
              maxLines: 1,
              style: const TextStyle(
                  fontFamily: 'Rubik', fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$ ${product.price}",
              // "\$200",
              maxLines: 1,
              style: const TextStyle(
                  fontFamily: 'Rubik', fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(170, 50)),
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      cartController.addToCart(product);
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
