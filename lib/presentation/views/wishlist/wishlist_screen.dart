import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:ecom_mvvm/presentation/views/wishlist/widgets/wishlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppText(text: "Wishlist", size: 24, color: primaryColor),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pushNamed('mainpage', pathParameters: {
                'initialIndex': '0',
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          )),
      body: Obx(
        () {
          if (cartController.wishlistItems.isEmpty) {
            return const Center(
              child: Text("No items in the wishlist"),
            );
          }
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: cartController.wishlistItems.length,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            itemBuilder: (context, index) {
              final product = cartController.wishlistItems[index];
              return WishlistTile(product, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDetailsScreen(productId: product.id);
                }));
              });
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          );
        },
      ),
    );
  }
}
