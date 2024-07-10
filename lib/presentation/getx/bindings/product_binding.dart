import 'package:ecom_mvvm/domain/usecases/fetch_by_category_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/get_product_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/product_details_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_category_price.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_price_usecase.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/order_controller.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    final productUseCase = Get.find<GetProductUsecase>();
    final productDetailsUsecase = Get.find<ProductDetailsUsecase>();
    final fetchByCategoryUsecase = Get.find<FetchByCategoryUsecase>();
    final sortByPriceUsecase = Get.find<SortByPriceUsecase>();
    final sortByCateogoryPriceUsecase = Get.find<SortByCateogryPriceUsecase>();

    Get.lazyPut(
      () => ProductController(
        getProductUsecase: productUseCase,
        productDetailsUsecase: productDetailsUsecase,
        fetchByCategoryUsecase: fetchByCategoryUsecase,
        sortByPriceUsecase: sortByPriceUsecase,
        sortByCateogryPriceUsecase: sortByCateogoryPriceUsecase,
      ),
    );

    Get.lazyPut(() => CartController());
    Get.lazyPut(() => OrderController());
  }
}
