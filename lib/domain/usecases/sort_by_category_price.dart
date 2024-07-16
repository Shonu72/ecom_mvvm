import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class SortByCateogryPriceUsecase {
  final ProductRepository productRepository;

  SortByCateogryPriceUsecase(this.productRepository);

  Future<Either<Failure, Map<String, dynamic>>> call(
      String category, String type) {
    return productRepository.sortProductByCategoryPrice(category, type);
  }
}
