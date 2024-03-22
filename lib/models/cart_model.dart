import 'package:shopping_demo/models/cart_item.dart';

class CartModel {
  int id;
  String cartName;
  List<CartItem> cartProductList = [];

  CartModel({
    required this.id,
    required this.cartName,
    required this.cartProductList});
}