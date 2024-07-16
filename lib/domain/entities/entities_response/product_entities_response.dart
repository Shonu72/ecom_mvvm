import 'package:ecom_mvvm/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntitiesResponse extends Equatable {
  final List<ProductEntity> productEntities;

  const ProductEntitiesResponse({required this.productEntities});

  @override
  List<Object?> get props => [productEntities];
}
