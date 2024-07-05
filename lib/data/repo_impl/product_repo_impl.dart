import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/datasources/product_datasource.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';

class ProductRepoImpl implements ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepoImpl(this.productDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts() {
    return productDataSource.getProducts();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductDetails(int id) {
    return productDataSource.getProductDetails(id);
  }
}
