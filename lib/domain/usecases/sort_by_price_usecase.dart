import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class SortByPriceUsecase {
  final ProductRepository productRepository;

  SortByPriceUsecase(this.productRepository);

  Future<Either<Failure, Map<String, dynamic>>> call(String type) {
    return productRepository.sortProductByPrice(type);
  }
}
