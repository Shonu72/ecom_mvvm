import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/data/datasource_impl/auth_data_source_impl.dart';
import 'package:ecom_mvvm/data/datasources/auth_data_source.dart';
import 'package:ecom_mvvm/data/repo_impl/auth_repo_impl.dart';
import 'package:ecom_mvvm/domain/repository/auth_repo.dart';
import 'package:ecom_mvvm/domain/usecases/login_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/bindings/auth_binding.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    _injectExternalDependencies();
    _injectDataSources();
    _injectRepositories();
    _injectChartererUsecases();

    AuthBinding().dependencies();
  }

  static void _injectExternalDependencies() {
    final dio = Dio(
      BaseOptions(baseUrl: ApiString.baseUrl),
    );
    Get.lazyPut<Dio>(() => dio);
  }

  static void _injectDataSources() {
    final dio = Get.find<Dio>();
    Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(dio));
  }

  static void _injectRepositories() {
    final authDatasource = Get.find<AuthDataSource>();

    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(authDatasource));
  }

  static void _injectChartererUsecases() {
    final authRepository = Get.find<AuthRepo>();

    Get.lazyPut(() => LoginUsecase(authRepository));
  }
}
