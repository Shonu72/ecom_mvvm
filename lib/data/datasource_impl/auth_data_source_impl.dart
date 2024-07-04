import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/core/utils/exception.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/datasources/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      String username, String password) async {
    try {
      try {
        final response =
            await Helper.sendRequest(RequestType.post, ApiString.login, data: {
          'username': username,
          'password': password,
        });

        if (response.statusCode == 200) {
          return Right(response.data);
        } else {
          return Left(ServerFailure(
              message: response.data['message'] ??
                  'Server error with status code: ${response.statusCode}'));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}
