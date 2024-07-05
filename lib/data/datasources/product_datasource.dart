import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';

abstract class ProductDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getProducts();
  Future<Either<Failure, Map<String, dynamic>>> getProductDetails(int id);
}
