import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  WishlistTile(
    this.product,
    this.onTap, {
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
                    onTap: onTap,
                    child: Image.network(
                      product.image,
                      height: 250,
                      fit: BoxFit.contain,
                      width: double.maxFinite,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Obx(() {
                    bool isInWishlist =
                        cartController.wishlistItems.contains(product);
                    return IconButton(
                      onPressed: () {
                        cartController.toggleWishlist(product);
                      },
                      icon: Icon(
                        isInWishlist ? Icons.cancel : Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                    );
                  }),
                ),
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
              maxLines: 1,
              style: const TextStyle(
                  fontFamily: 'Rubik', fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$ ${product.price}",
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
                    minimumSize: WidgetStateProperty.all(const Size(170, 40)),
                    backgroundColor: WidgetStateProperty.all(primaryColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    cartController.addToCart(product);
                    cartController
                        .toggleWishlist(product); // Remove from wishlist
                  },
                  child: const Text(
                    "Move to Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
