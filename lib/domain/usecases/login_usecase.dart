import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/domain/repository/auth_repo.dart';

class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase(this.authRepo);

  Future<Either<Failure, Map<String, dynamic>>> call(
      String username, String password) async {
    return authRepo.login(username, password);
  }
}
