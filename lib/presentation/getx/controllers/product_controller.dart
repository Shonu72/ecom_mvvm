import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/domain/usecases/fetch_by_category_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/get_product_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/product_details_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_category_price.dart';
import 'package:ecom_mvvm/domain/usecases/sort_by_price_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetProductUsecase _getProductUsecase;
  final ProductDetailsUsecase _productDetailsUsecase;
  final FetchByCategoryUsecase _fetchByCategoryUsecase;
  final SortByPriceUsecase _sortByPriceUsecase;
  final SortByCateogryPriceUsecase _sortByCateogryPriceUsecase;

  ProductController({
    required GetProductUsecase getProductUsecase,
    required ProductDetailsUsecase productDetailsUsecase,
    required FetchByCategoryUsecase fetchByCategoryUsecase,
    required SortByPriceUsecase sortByPriceUsecase,
    required SortByCateogryPriceUsecase sortByCateogryPriceUsecase,
  })  : _getProductUsecase = getProductUsecase,
        _productDetailsUsecase = productDetailsUsecase,
        _fetchByCategoryUsecase = fetchByCategoryUsecase,
        _sortByPriceUsecase = sortByPriceUsecase,
        _sortByCateogryPriceUsecase = sortByCateogryPriceUsecase;

  var isLoading = true.obs;
  final errorMessage = ''.obs;
  final products = List<ProductModel>.empty().obs;

  Future<List<ProductModel>> getProducts() async {
    try {
      isLoading(true);
      debugPrint('Loading started');
      final failureOrSuccess = await _getProductUsecase();
      debugPrint('Request completed');

      failureOrSuccess.fold((failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint('Error: ${errorMessage.value}');
        Helper.toast(errorMessage.value);
      }, (success) {
        products.value = success['products'];
        debugPrint('Products loaded: $products');
      });
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    } finally {
      isLoading(false);

      debugPrint('Loading ended');
    }
    return products;
  }

  Future<List<ProductModel>> productDetails(int id) async {
    try {
      isLoading(true);
      debugPrint('Loading started');
      final failureOrSuccess = await _productDetailsUsecase(id);
      debugPrint('Request completed');

      failureOrSuccess.fold((failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint('Error: ${errorMessage.value}');
        Helper.toast(errorMessage.value);
      }, (success) {
        products.value = success['products'];
        isLoading(false);
        debugPrint('Products loaded: $products');
      });
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    } finally {
      isLoading(false);
      debugPrint('Loading ended');
    }
    return products;
  }

  Category? category;
  Future<void> fetchProductByCategory(category) async {
    try {
      isLoading(true);
      debugPrint('Loading started');
      final failureOrSuccess = await _fetchByCategoryUsecase(category);
      debugPrint('Request completed');

      failureOrSuccess.fold((failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint('Error: ${errorMessage.value}');
        Helper.toast(errorMessage.value);
      }, (success) {
        products.value = success['products'];
        isLoading(false);
        debugPrint('Products loaded: $products');
      });
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    } finally {
      isLoading(false);
      debugPrint('Loading ended');
    }
  }

  Future<void> sortByPrice(String type) async {
    try {
      isLoading(true);
      debugPrint('Loading started');
      final failureOrSuccess = await _sortByPriceUsecase(type);
      debugPrint('Request completed');

      failureOrSuccess.fold((failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint('Error: ${errorMessage.value}');
        Helper.toast(errorMessage.value);
      }, (success) {
        products.value = success['products'];
        isLoading(false);
        debugPrint('Products loaded: $products');
      });
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    } finally {
      isLoading(false);
      debugPrint('Loading ended');
    }
  }

  Future<void> sortByCategoryPrice(category, String type) async {
    try {
      isLoading(true);
      debugPrint('Loading started');
      final failureOrSuccess =
          await _sortByCateogryPriceUsecase(category, type);
      debugPrint('Request completed');

      failureOrSuccess.fold((failure) {
        errorMessage.value = Helper.convertFailureToMessage(failure);
        debugPrint('Error: ${errorMessage.value}');
        Helper.toast(errorMessage.value);
      }, (success) {
        products.value = success['products'];
        isLoading(false);
        debugPrint('Products loaded: $products');
      });
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Catch error: ${errorMessage.value}');
      Helper.toast(errorMessage.value);
    } finally {
      isLoading(false);
      debugPrint('Loading ended');
    }
  }
}
