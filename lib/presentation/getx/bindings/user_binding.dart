import 'package:ecom_mvvm/domain/usecases/fetch_user_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/login_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/auth_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/user_controller.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    final fetchUser = Get.find<FetchUserUsecase>();

    Get.lazyPut(() => UserController(fetchUserUsecase: fetchUser));
  }
}
