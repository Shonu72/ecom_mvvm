import 'package:ecom_mvvm/data/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxMap<ProductModel, int> cartItems = <ProductModel, int>{}.obs;
  RxList<ProductModel> wishlistItems = <ProductModel>[].obs;

  int get count => cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalPrice => cartItems.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void clearCart() {
    cartItems.clear();
  }

  void addToCart(ProductModel item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    } else {
      cartItems[item] = 1;
    }
    print('${item.title} added to cart');
  }

  void removeFromCart(ProductModel item) {
    if (cartItems.containsKey(item) && cartItems[item]! > 1) {
      cartItems[item] = cartItems[item]! - 1;
    } else {
      cartItems.remove(item);
    }
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
      print('${item.title} added to wishlist');
    } else {
      wishlistItems.removeAt(index);
      print('${item.title} removed from wishlist');
    }
  }

  bool isInWishlist(ProductModel item) {
    return wishlistItems.any((wishlistItem) => wishlistItem.id == item.id);
  }
}
