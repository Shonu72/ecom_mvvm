import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/datasources/user_datasource.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';
import 'package:ecom_mvvm/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepoImpl(this.userDataSource);

  @override
  Future<Either<Failure, UserModel>> fetchUsers(int id) {
    return userDataSource.fetchUsers(id);
  }
}
