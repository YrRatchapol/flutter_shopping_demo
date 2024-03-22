import 'package:flutter/cupertino.dart';
import 'package:shopping_demo/models/product.dart';
import 'package:shopping_demo/scenes/cart_list/cart_list_page.dart';
import 'package:shopping_demo/scenes/selecting_product/selecting_product_page.dart';

class ProductListRouter{
  late BuildContext _context;

  ProductListRouter(BuildContext context) {
    _context = context;
  }

  void toProductPage({required Product product}) {
    Navigator.of(_context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => SelectingProductPage(product: product),
      ),
    );
  }

  void toCartList() {
    Navigator.of(_context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => const CartListPage(),
      ),
    );
  }
}