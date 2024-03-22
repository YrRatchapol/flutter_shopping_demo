import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/models/cart_model.dart';
import 'package:shopping_demo/providers/product_provider.dart';

class TrackingListInteractor {
  late BuildContext _context;

  TrackingListInteractor(BuildContext context) {
    _context = context;
  }

  double getTotalPriceByCartIndex(int index) {
    return _context.read<ProductProvider>().totalPriceWithCheckOutCart(cartIndex: index);
  }

  List<CartModel> getCheckoutCartList() {
    return _context.watch<ProductProvider>().checkoutCartList;
  }
}