import 'package:ecom_mvvm/domain/usecases/login_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final loginUser = Get.find<LoginUsecase>();

    Get.lazyPut(() => AuthController(loginUsecase: loginUser));
  }
}
