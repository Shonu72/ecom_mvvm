import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserModel>> fetchUsers(int id);
}
