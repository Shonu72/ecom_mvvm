import 'package:animations/animations.dart';
import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/categories.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  AllProductScreenState createState() => AllProductScreenState();
}

class AllProductScreenState extends State<AllProductScreen> {
  final ProductController productController = Get.find<ProductController>();
  int _value = 0;

  static const List<String> categoryTitles = [
    "All",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            size: 30,
            color: primaryColor,
          ),
        ),
        title: const Text(
          'Explore',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                // showSearch(
                //   context: context,
                //   delegate: MySearchDelegate(),
                // );
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: secondaryColor,
              thickness: 0.4,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categoryTitles.length, (index) {
                    return MyRadioListTile<int>(
                      value: index,
                      groupValue: _value,
                      leading: categoryTitles[index],
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          if (_value == 0) {
                            productController.getProducts();
                          } else {
                            productController
                                .fetchProductByCategory(categoryTitles[_value]);
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Wrap(
                    children: [
                      Icon(Icons.filter_alt_rounded),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Filter")
                    ],
                  ),
                  InkWell(
                    onTap: showsorting,
                    child: const Wrap(
                      children: [
                        Icon(Icons.format_align_center_sharp),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Sort By")
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: productController.products.length,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OpenContainer(
                        transitionType: ContainerTransitionType.fade,
                        transitionDuration: const Duration(milliseconds: 300),
                        closedBuilder: (context, action) {
                          return ProductTile(
                            productController.products[index],
                            action,
                          );
                        },
                        openBuilder: (context, action) {
                          return ProductDetailsScreen(
                            productId: productController.products[index].id,
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

  void showsorting() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 180,
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sort By",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text("Price: High to low"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        if (_value == 0) {
                          productController.sortByPrice("desc");
                        } else {
                          productController.sortByCategoryPrice(
                              categoryTitles[_value], "desc");
                        }
                      });
                    },
                  ),
                  ListTile(
                    title: const Text("Price: Low to High"),
                    onTap: () {
                      setState(() {
                        context.pop();
                        if (_value == 0) {
                          productController.sortByPrice("aesc");
                        } else {
                          productController.sortByCategoryPrice(
                              categoryTitles[_value], "aesc");
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
