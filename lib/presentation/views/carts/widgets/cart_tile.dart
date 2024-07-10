import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:ecom_mvvm/presentation/views/checkout/checkout_page.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTile extends StatelessWidget {
  final ProductModel product;

  const CartTile({
    super.key,
    required this.product,
    required int quantity,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final productController = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SizedBox(
        child: Card(
          borderOnForeground: true,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                        productId: productController.products
                                            .firstWhere(
                                                (p) => p.id == product.id)
                                            .id,
                                      )));
                          // GoRouter.of(context)
                          //     .pushNamed('productdetails', pathParameters: {
                          //   "productId":
                          //       "${productController.products.firstWhere((p) => p.id == product.id).id}"
                          // });
                        },
                        child: Image.network(
                          product.image,
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.removeFromCart(product);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Obx(() => Text(
                              '${cartController.getProductQuantity(product)}')),
                          IconButton(
                            onPressed: () {
                              cartController.addToCart(product);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const Text(
                            "In stock",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                          const Text(
                            "Eligible for free shipping",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Category: ${product.category}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(primaryColor),
                            ),
                            onPressed: () {
                              // context.push('/checkout');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckoutPage()));
                              // context.pushNamed('checkout');
                            },
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
