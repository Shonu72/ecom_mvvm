import 'package:equatable/equatable.dart';

class CartEntities extends Equatable {
  final String productId;
  final String productName;
  int quantity;
  final double price;

  CartEntities({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [productId, productName, quantity, price];
}
