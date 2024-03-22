import 'package:shopping_demo/models/product.dart';

class CartItem {
  late Product product;
  int quantity;
  String? note;

  CartItem({
    required this.product,
    required this.quantity,
    this.note});
}