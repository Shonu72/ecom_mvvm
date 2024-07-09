import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/models/user_model.dart';
import 'package:ecom_mvvm/domain/usecases/fetch_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FetchUserUsecase fetchUserUsecase;

  UserController({required this.fetchUserUsecase});

  final errorMessage = ''.obs;
  final userResponse = Rxn<UserModel>();

  Future<void> fetchUsers({required int id}) async {
    try {
      final failureOrSuccess = await fetchUserUsecase(id);
      failureOrSuccess.fold(
        (failure) {
          errorMessage.value = Helper.convertFailureToMessage(failure);
          debugPrint('Error: ${errorMessage.value}');
          Helper.toast(errorMessage.value);
        },
        (success) {
          userResponse.value = success;
          debugPrint('User loaded: ${userResponse.value?.username}');
        },
      );
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    }
  }
}
