import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Map<String, dynamic>>> getProducts();
  Future<Either<Failure, Map<String, dynamic>>> getProductDetails(int id);
  Future<Either<Failure, Map<String, dynamic>>> fetchProductByCategory(
      String category);
  Future<Either<Failure, Map<String, dynamic>>> sortProductByPrice(String type);
  Future<Either<Failure, Map<String, dynamic>>> sortProductByCategoryPrice(
      String category, String type);
}
