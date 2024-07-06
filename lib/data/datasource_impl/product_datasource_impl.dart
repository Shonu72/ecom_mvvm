import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/core/utils/exception.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/datasources/product_datasource.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';

class ProductDatasourceImpl implements ProductDataSource {
  final Dio dio;

  ProductDatasourceImpl(this.dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts() async {
    try {
      final response =
          await Helper.sendRequest(RequestType.get, ApiString.products);
      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var product in response.data) {
          products.add(ProductModel.fromMap(product));
        }
        return Right({'products': products});
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ??
                'Server error with status code: ${response.statusCode}'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductDetails(
      int id) async {
    try {
      final response = await Helper.sendRequest(
          RequestType.get, '${ApiString.products}/$id');
      if (response.statusCode == 200) {
        final product = ProductModel.fromMap(response.data);
        return Right({'product': product});
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ??
                'Server error with status code: ${response.statusCode}'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchProductByCategory(
      String category) async {
    try {
      final response = await Helper.sendRequest(
          RequestType.get, '${ApiString.fetchbycategory}/$category');
      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var product in response.data) {
          products.add(ProductModel.fromMap(product));
        }
        return Right({'products': products});
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ??
                'Server error with status code: ${response.statusCode}'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sortProductByPrice(
      String type) async {
    try {
      final response = await Helper.sendRequest(
          RequestType.get, '${ApiString.products}?sort=$type');
      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var product in response.data) {
          products.add(ProductModel.fromMap(product));
        }
        return Right({'products': products});
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ??
                'Server error with status code: ${response.statusCode}'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sortProductByCategoryPrice(
      String category, String type) async {
    try {
      final response = await Helper.sendRequest(
          RequestType.get, '${ApiString.fetchbycategory}/$category?sort=$type');
      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var product in response.data) {
          products.add(ProductModel.fromMap(product));
        }
        return Right({'products': products});
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ??
                'Server error with status code: ${response.statusCode}'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}
