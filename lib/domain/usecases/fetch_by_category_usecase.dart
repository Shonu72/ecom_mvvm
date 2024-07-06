import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class FetchByCategoryUsecase {
  final ProductRepository productRepository;

  FetchByCategoryUsecase(this.productRepository);

  Future<Either<Failure, Map<String, dynamic>>> call(String category) {
    return productRepository.fetchProductByCategory(category);
  }
}
