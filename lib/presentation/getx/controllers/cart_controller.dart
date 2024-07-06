import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxMap<ProductModel, int> cartItems = <ProductModel, int>{}.obs;
  RxList<ProductModel> wishlistItems = <ProductModel>[].obs;

  int get count => cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalPrice => cartItems.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void addToCart(ProductModel item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    } else {
      cartItems[item] = 1;
    }
    Helper.toast('${item.title} added to cart');
  }

  void removeFromCart(ProductModel item) {
    if (cartItems.containsKey(item) && cartItems[item]! > 1) {
      cartItems[item] = cartItems[item]! - 1;
    } else {
      cartItems.remove(item);
    }
    Helper.toast('${item.title} removed from cart');
  }

  int getProductQuantity(ProductModel product) {
    return cartItems[product] ?? 0;
  }

  void addToWishlist(ProductModel item) {
    // Check if the item already exists in the wishlist
    int index =
        wishlistItems.indexWhere((wishlistItem) => wishlistItem.id == item.id);
    if (index == -1) {
      wishlistItems.add(item);
    }
  }

  void removeFromWishlist(ProductModel item) {
    wishlistItems.remove(item);
  }

  bool isInWishlist(ProductModel item) {
    return wishlistItems.any((wishlistItem) => wishlistItem.id == item.id);
  }
}
