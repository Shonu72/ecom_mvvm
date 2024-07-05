import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:ecom_mvvm/domain/usecases/get_product_usecase.dart';
import 'package:ecom_mvvm/domain/usecases/product_details_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetProductUsecase _getProductUsecase;
  final ProductDetailsUsecase _productDetailsUsecase;

  ProductController(
      {required GetProductUsecase getProductUsecase,
      required ProductDetailsUsecase productDetailsUsecase})
      : _getProductUsecase = getProductUsecase,
        _productDetailsUsecase = productDetailsUsecase;

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
        debugPrint('Products loaded: ${products.value}');
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
        debugPrint('Products loaded: ${products.value}');
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
}
