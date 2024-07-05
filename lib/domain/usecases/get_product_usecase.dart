import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class GetProductUsecase {
  final ProductRepository productRepository;

  GetProductUsecase(this.productRepository);

   Future<Either<Failure, Map<String, dynamic>>> call() async {
    return productRepository.getProducts();
  }
}
