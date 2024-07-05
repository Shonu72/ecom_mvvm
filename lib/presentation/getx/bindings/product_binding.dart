import 'package:ecom_mvvm/domain/usecases/get_product_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/product_details_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    final productUseCase = Get.find<GetProductUsecase>();
    final productDetailsUsecase = Get.find<ProductDetailsUsecase>();

    Get.lazyPut(() => ProductController(
        getProductUsecase: productUseCase,
        productDetailsUsecase: productDetailsUsecase));
  }
}
