import 'package:ecom_mvvm/data/models/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final double totalAmount;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((product) => product.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      products: List<ProductModel>.from(
          map['products']?.map((item) => ProductModel.fromMap(item))),
      totalAmount: map['totalAmount'],
      date: DateTime.parse(map['date']),
    );
  }
}
