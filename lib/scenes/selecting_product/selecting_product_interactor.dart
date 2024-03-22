import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/models/cart_item.dart';
import 'package:shopping_demo/models/product.dart';
import 'package:shopping_demo/providers/product_provider.dart';

class SelectingProductInteractor {
  late BuildContext _context;

  late Product product;
  int quantity = 1;
  CartItem? productInCart;

  SelectingProductInteractor(BuildContext context, {required this.product }) {
    _context = context;
    _initProductInCart();
  }

  void _initProductInCart() {
    var cartProductList = _context.read<ProductProvider>().cartProductList;
    try {
      productInCart = cartProductList.firstWhere((value) => value.product.id == product.id);
    } catch(e) {
      print(e);
    }
  }

  void addProductToCart({required String note}) {
    _context.read<ProductProvider>().addProductToCartList(product, quantity, note);
  }
}