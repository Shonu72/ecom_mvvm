import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/data/datasource_impl/auth_data_source_impl.dart';
import 'package:ecom_mvvm/data/datasource_impl/product_datasource_impl.dart';
import 'package:ecom_mvvm/data/datasource_impl/user_datasource_impl.dart';
import 'package:ecom_mvvm/data/datasources/auth_data_source.dart';
import 'package:ecom_mvvm/data/datasources/product_datasource.dart';
import 'package:ecom_mvvm/data/datasources/user_datasource.dart';
import 'package:ecom_mvvm/data/repo_impl/auth_repo_impl.dart';
import 'package:ecom_mvvm/data/repo_impl/product_repo_impl.dart';
import 'package:ecom_mvvm/data/repo_impl/user_repo_impl.dart';
import 'package:ecom_mvvm/domain/repository/auth_repo.dart';
import 'package:ecom_mvvm/domain/repository/product_repository.dart';
import 'package:ecom_mvvm/domain/repository/user_repo.dart';
import 'package:ecom_mvvm/domain/usecases/fetch_by_category_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/fetch_user_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/get_product_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/login_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/product_details_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_category_price.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_price_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/bindings/auth_binding.dart';
import 'package:ecom_mvvm/presentation/getx/bindings/product_binding.dart';
import 'package:ecom_mvvm/presentation/getx/bindings/user_binding.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    _injectExternalDependencies();
    _injectDataSources();
    _injectRepositories();
    _injectChartererUsecases();

    AuthBinding().dependencies();
    ProductBinding().dependencies();
    UserBinding().dependencies();
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
    Get.lazyPut<ProductDataSource>(() => ProductDatasourceImpl(dio));
    Get.lazyPut<UserDataSource>(() => UserDatasourceImpl(dio));
  }

  static void _injectRepositories() {
    final authDatasource = Get.find<AuthDataSource>();
    final productDatasource = Get.find<ProductDataSource>();
    final userDatasource = Get.find<UserDataSource>();

    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(authDatasource));
    Get.lazyPut<ProductRepository>(() => ProductRepoImpl(productDatasource));
    Get.lazyPut<UserRepository>(() => UserRepoImpl(userDatasource));
  }

  static void _injectChartererUsecases() {
    final authRepository = Get.find<AuthRepo>();
    final productRepository = Get.find<ProductRepository>();
    final userRepository = Get.find<UserRepository>();

    Get.lazyPut(() => LoginUsecase(authRepository));
    Get.lazyPut(() => GetProductUsecase(productRepository));
    Get.lazyPut(() => ProductDetailsUsecase(productRepository));
    Get.lazyPut(() => FetchByCategoryUsecase(productRepository));
    Get.lazyPut(() => SortByPriceUsecase(productRepository));
    Get.lazyPut(() => SortByCateogryPriceUsecase(productRepository));
    Get.lazyPut(() => FetchUserUsecase(userRepository));
  }
}
