import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUsecase _loginUsecase;

  AuthController({required LoginUsecase loginUsecase})
      : _loginUsecase = loginUsecase;

  final errorMessage = ''.obs;
  final loginResponse = {}.obs;

  Future<bool> loginUser(
      {required String username, required String password}) async {
    final failureOrSuccess = await _loginUsecase(username, password);

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helper.toast(errorMessage.value);
      },
      (success) {
        loginResponse.value = success;
        Helper.toast('Login Successful');
        Helper.saveUser(key: "isLoggedIn", value: true);
        Helper.saveApiToken(key: success['token']);
      },
    );

    return failureOrSuccess.isRight() ? true : false;
  }

  Future<void> logOut() async {
    Helper.saveUser(key: "isLoggedIn", value: false);
    Helper.saveApiToken(key: '');
  }
}
