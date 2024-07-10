import 'dart:convert';

import 'package:ecom_mvvm/data/models/order_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> addOrder(OrderModel order) async {
    orders.add(order);
    saveOrders();
  }

  Future<void> saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final orderData = orders.map((order) => order.toMap()).toList();
    await prefs.setString('orders', jsonEncode(orderData));
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final orderDataString = prefs.getString('orders');
    if (orderDataString != null) {
      final orderDataList = jsonDecode(orderDataString) as List;
      final loadedOrders =
          orderDataList.map((item) => OrderModel.fromMap(item)).toList();
      orders.addAll(loadedOrders);
    }
  }
}
