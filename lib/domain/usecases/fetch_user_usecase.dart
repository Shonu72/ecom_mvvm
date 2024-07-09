import 'package:dartz/dartz.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';
import 'package:ecom_mvvm/domain/repository/user_repo.dart';

class FetchUserUsecase {
  final UserRepository _userRepository;

  FetchUserUsecase(UserRepository userRepository)
      : _userRepository = userRepository;

  Future<Either<Failure, UserModel>> call(int id) {
    return _userRepository.fetchUsers(id);
  }
}
