import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> fetchUsers(int id);
}
