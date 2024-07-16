import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/core/utils/exception.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/datasources/user_datasource.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';

class UserDatasourceImpl implements UserDataSource {
  final Dio dio;

  UserDatasourceImpl(this.dio);

  @override
  Future<Either<Failure, UserModel>> fetchUsers(int id) async {
    try {
      final response =
          await Helper.sendRequest(RequestType.get, "${ApiString.user}/$id");

      if (response.statusCode == 200) {
        final users = UserModel.fromMap(response.data);
        print("users: $users");
        return Right(users);
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
