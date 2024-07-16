import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/domain/entities/entities_response/product_entities_response.dart';

class ProductResponse extends ProductEntitiesResponse {
  final List<ProductModel> productModels;

  const ProductResponse({required this.productModels})
      : super(productEntities: productModels);

  @override
  List<Object?> get props => [productModels];

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      productModels: List<ProductModel>.from(
        map['products'].map(
          (x) => ProductModel.fromMap(x),
        ),
      ),
    );
  }
}
