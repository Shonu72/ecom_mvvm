import 'dart:convert';

import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxMap<ProductModel, int> cartItems = <ProductModel, int>{}.obs;
  RxList<ProductModel> wishlistItems = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCartData();
    loadWishlistData();
  }

  int get count => cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalPrice => cartItems.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void clearCart() {
    cartItems.clear();
    saveCartData();
  }

  void addToCart(ProductModel item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    } else {
      cartItems[item] = 1;
    }
    saveCartData();
    print('${item.title} added to cart');
  }

  void removeFromCart(ProductModel item) {
    if (cartItems.containsKey(item) && cartItems[item]! > 1) {
      cartItems[item] = cartItems[item]! - 1;
    } else {
      cartItems.remove(item);
    }
    saveCartData();
    print('${item.title} removed from cart');
  }

  int getProductQuantity(ProductModel product) {
    return cartItems[product] ?? 0;
  }

  void toggleWishlist(ProductModel item) {
    int index =
        wishlistItems.indexWhere((wishlistItem) => wishlistItem.id == item.id);
    if (index == -1) {
      wishlistItems.add(item);
      saveWishlistData();
      print('${item.title} added to wishlist');
    } else {
      wishlistItems.removeAt(index);
      saveWishlistData();
      print('${item.title} removed from wishlist');
    }
  }

  bool isInWishlist(ProductModel item) {
    return wishlistItems.any((wishlistItem) => wishlistItem.id == item.id);
  }

// save cart and wishlist data in local storage

  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData =
        cartItems.map((key, value) => MapEntry(jsonEncode(key.toMap()), value));
    await prefs.setString('cartData', jsonEncode(cartData));
  }

  Future<void> loadCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartDataString = prefs.getString('cartData');
    if (cartDataString != null) {
      final cartDataMap = jsonDecode(cartDataString) as Map<String, dynamic>;
      final loadedCartItems = cartDataMap.map((key, value) =>
          MapEntry(ProductModel.fromMap(jsonDecode(key)), value as int));
      cartItems.addAll(loadedCartItems);
    }
  }

  Future<void> saveWishlistData() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistData = wishlistItems.map((item) => item.toMap()).toList();
    await prefs.setString('wishlistData', jsonEncode(wishlistData));
  }

  Future<void> loadWishlistData() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistDataString = prefs.getString('wishlistData');
    if (wishlistDataString != null) {
      final wishlistDataList = jsonDecode(wishlistDataString) as List;
      final loadedWishlistItems = wishlistDataList
          .map((itemJson) => ProductModel.fromMap(itemJson))
          .toList();
      wishlistItems.addAll(loadedWishlistItems);
    }
  }
}
