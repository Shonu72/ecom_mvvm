import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> login(
      String username, String password);
}
