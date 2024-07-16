import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class ProductDetailsUsecase {
  final ProductRepository productRepository;

  ProductDetailsUsecase(this.productRepository);

  Future<Either<Failure, Map<String, dynamic>>> call(int id) async {
    return productRepository.getProductDetails(id);
  }
}
