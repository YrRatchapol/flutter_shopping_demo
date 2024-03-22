import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/models/cart_item.dart';
import 'package:shopping_demo/models/cart_model.dart';
import 'package:shopping_demo/models/product.dart';
import 'package:shopping_demo/providers/product_provider.dart';

class CartListInteractor {
  late BuildContext _context;

  CartListInteractor(BuildContext context) {
    _context = context;
  }

  void addNewCart({required String name}) {
    _context.read<ProductProvider>().addNewCart(name: name);
  }

  String getCartName() {
    final cartSelectedIndex =_context.read<ProductProvider>().cartSelectedIndex;
    return _context.read<ProductProvider>().cartList[cartSelectedIndex].cartName;
  }

  void addProduct({required CartItem cart}) {
    _context.read<ProductProvider>().addProductToCartList(cart.product, cart.quantity + 1, cart.note ?? "");
  }

  void removeProduct({required Product product}) {
    _context.read<ProductProvider>().removeProductFromCartList(product);
  }

  void deleteProduct({required Product product}) {
    _context.read<ProductProvider>().deleteProductFromCartList(product);
  }

  void checkOutCart() {
    _context.read<ProductProvider>().checkoutSelectedCart();
  }

  void deleteCart() {
    _context.read<ProductProvider>().deleteCart();
  }

  int getCartSelectedIndex() {
    return _context.read<ProductProvider>().cartSelectedIndex;
  }

  List<CartModel> getCartList() {
    return _context.read<ProductProvider>().cartList;
  }

  void changeCartByIndex(int index) {
    _context.read<ProductProvider>().changeCart(cartIndex: index);
  }

  List<CartItem> getCartProductList() {
    return _context.read<ProductProvider>().cartProductList;
  }

  double getTotalPrice() {
    return _context.read<ProductProvider>().totalPrice;
  }
}