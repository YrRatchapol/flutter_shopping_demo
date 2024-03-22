import 'package:flutter/cupertino.dart';
import 'package:shopping_demo/models/cart_item.dart';
import 'package:shopping_demo/models/cart_model.dart';
import 'package:shopping_demo/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList = []; // Home Page
  List<Product> savedProductList = []; // Saved Page
  List<CartModel> cartList = [CartModel(id: 0, cartName: "Cart", cartProductList: [])]; // Cart Page
  List<CartModel> checkoutCartList = [];
  int cartSelectedIndex = 0;
  int cartRunId = 0;

  void changeCart({required int cartIndex}) {
    cartSelectedIndex = cartIndex;
  }

  void addNewCart({required String name}) {
    cartRunId = cartRunId + 1;
    cartList.add(CartModel(id: cartRunId, cartName: name, cartProductList: []));
    cartSelectedIndex = cartList.length - 1;
  }

  List<CartItem> get cartProductList {
    return cartList[cartSelectedIndex].cartProductList;
  }

  double get totalPrice {
    double sum = 0;
    for (CartItem element in cartProductList) {
      int quantity = element.quantity;
      double price = element.product.price;
      sum += price * quantity;
    }
    return sum;
  }

  double totalPriceWithCheckOutCart({ required int cartIndex}) {
    double sum = 0;
    for (CartItem element in checkoutCartList[cartIndex].cartProductList) {
      int quantity = element.quantity;
      double price = element.product.price;
      sum += price * quantity;
    }
    return sum;
  }

  void addProductList(List<Product> list) {
    productList = list;
    notifyListeners();
  }

  void addProductToSavedProductList(Product product) {
    product.isFavorite = true;
    savedProductList.insert(0, product);
    notifyListeners();
  }

  void removeProductFromSavedProductList(Product product) {
    if (savedProductList.contains(product)) {
      product.isFavorite = false;
      savedProductList.remove(product);
    }
    notifyListeners();
  }

  void addProductToCartList(Product product, int quantity, String note) {
    int index = cartProductList.indexWhere((element) => element.product.id == product.id);
    if (index > -1) {
      // If the product found in the list, then increase the quantity by 1.
      cartProductList[index].quantity = quantity;
      cartProductList[index].note = note;
    } else {
      // Otherwise add the product to the list.
      CartItem item = CartItem(product: product, quantity: quantity, note: note);
      cartProductList.add(item);
    }
    notifyListeners();
  }

  void removeProductFromCartList(Product product) {
    int index = cartProductList.indexWhere((element) => element.product.id == product.id);
    CartItem item = cartProductList[index];
    if (index > -1 && item.quantity > 1) {
      // If the product found in the cart list, then decrease the quantity by 1.
      cartProductList[index].quantity -= 1;
    } else {
      // Otherwise remove the product from the cart list.
      cartProductList.remove(item);
    }
    notifyListeners();
  }

  void deleteProductFromCartList(Product product) {
    int index = cartProductList.indexWhere((element) => element.product.id == product.id);
    CartItem cartItem = cartProductList[index];
    if (index > -1 && cartItem.quantity > 0) {
      // reset quantity and remove all of the products from the cart list.
      cartProductList.remove(cartItem);
    }

    notifyListeners();
  }

  void checkoutSelectedCart() {
    if (cartList[cartSelectedIndex].cartProductList.isNotEmpty) {
      checkoutCartList.add(cartList[cartSelectedIndex]);
      deleteCart();
      notifyListeners();
    }
  }

  void deleteCart() {
    cartList.removeAt(cartSelectedIndex);
    if (cartList.isEmpty) {
      cartList.insert(0, CartModel(id: 0, cartName: "Cart", cartProductList: [])); // Start Cart
    }
    cartSelectedIndex = 0;
  }
}
