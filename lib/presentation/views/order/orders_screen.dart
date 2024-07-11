import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/order_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'My Orders',
          color: primaryColor,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
      ),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return const Center(
            child: AppText(text: 'No orders yet!', color: secondaryColor),
          );
        } else {
          return ListView.builder(
            itemCount: orderController.orders.length,
            itemBuilder: (context, index) {
              final order = orderController.orders[index];
              return Card(
                color: Colors.white54,
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Order ID: ${order.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                      Text(
                          'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(order.date)}'),
                    ],
                  ),
                  children: order.products.map((product) {
                    return ListTile(
                      onTap: () {
                        GoRouter.of(context).pushNamed('productdetails',
                            pathParameters: {"productId": "${product.id}"});
                      },
                      leading: Image.network(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${product.price.toStringAsFixed(2)}'),
                          Text(
                            'Quantity: ${orderController.orders[index].products.where((p) => p.id == product.id).length}',
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
