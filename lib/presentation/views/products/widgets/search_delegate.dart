import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<ProductModel> productList;

  MySearchDelegate({required this.productList});

  @override
  String get searchFieldLabel => 'Search...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "null");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = productList
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildProductList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = productList
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildProductList(suggestions);
  }

  Widget _buildProductList(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Center(child: Text('No results found.'));
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text('\$${product.price.toString()}'),
          leading: Image.network(
            product.image,
            height: 60,
            width: 60,
          ),
          onTap: () {
            GoRouter.of(context).pushNamed('productdetails', pathParameters: {
              "productId":
                  "${products.firstWhere((p) => p.id == product.id).id}"
            });
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      // inputDecorationTheme: searchFieldDecorationTheme?.copyWith(
      //   labelStyle: const TextStyle(color: Colors.white),
      //   border: const OutlineInputBorder(
      //       borderSide: BorderSide(color: primaryColor),
      //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
      // ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: primaryColor),
            titleTextStyle: const TextStyle(color: primaryColor),
          ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleSmall: const TextStyle(color: primaryColor),
          ),
    );
  }
}
