import 'package:get/get.dart';
import 'package:darra5/models/investment.dart';

class CartController extends GetxController {
  var cartItems = {}.obs; // Use a map to store item and quantity pairs
void clearCart() {
    cartItems.clear();
  }
  void addToCart(Investment investment) {
    if (cartItems.containsKey(investment)) {
      cartItems[investment] += 1;
    } else {
      cartItems[investment] = 1;
    }
  }

  void removeFromCart(Investment investment) {
    if (cartItems.containsKey(investment) && cartItems[investment] > 1) {
      cartItems[investment] -= 1;
    } else {
      cartItems.remove(investment);
    }
  }

  void removeItem(Investment investment) {
    cartItems.remove(investment);
  }

  int get itemCount => cartItems.length;

  int getItemQuantity(Investment investment) {
    return cartItems[investment] ?? 0;
  }

 int get totalItems => cartItems.values.fold(0, (total, value) => total + value as int);
}
