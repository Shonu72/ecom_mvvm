import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/datasources/auth_data_source.dart';
import 'package:ecom_mvvm/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      String username, String password) {
    return authDataSource.login(username, password);
  }
}
