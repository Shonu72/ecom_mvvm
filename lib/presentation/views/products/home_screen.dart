import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/categories.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/image_slider.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'hCommerce'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.document_scanner_outlined,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: secondaryColor,
              thickness: 0.4,
            ),
            const ImageSlider(),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                        fontFamily: 'Rubik'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // ContainerList(),
            const ContainerList(),
            const SizedBox(height: 10),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                  child: Text(
                    'Trending',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                        fontFamily: 'Rubik'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 280,
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount:
                        productController.products.length, // Fixed itemCount
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        productController.products[index],
                        () {
                          // context.pushNamed(
                          //   'productdetails',
                          //   pathParameters: {
                          //     'id': productController.products[index].id
                          //         .toString()
                          //   },
                          // );

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetailsScreen(
                              productId: productController.products[index].id,
                            );
                          }));
                        },
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                }
              }),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                  child: Text(
                    'Sales',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                        fontFamily: 'Rubik'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 280,
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount:
                        productController.products.length, // Fixed itemCount
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        productController.products[index],
                        () {
                          context.pushNamed(
                            'productdetails',
                            pathParameters: {
                              'id': productController.products[index].id
                                  .toString()
                            },
                          );
                        },
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
