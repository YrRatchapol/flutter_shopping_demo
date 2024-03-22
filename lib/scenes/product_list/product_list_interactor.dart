import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/models/product.dart';
import 'dart:convert';

import 'package:shopping_demo/providers/product_provider.dart';

class ProductListInteractor {
  late BuildContext _context;

  ProductListInteractor(BuildContext context) {
    _context = context;

    _intProductList();
  }

  List<Product> getProductList() {
    return _context.read<ProductProvider>().productList;
  }

  void _intProductList() {
    if (_context.read<ProductProvider>().productList.isEmpty) {
      _doFetchProductList().then((list) {
        _context.read<ProductProvider>().addProductList(list);
      });
    }
  }

  Future<List<Product>> _doFetchProductList() async {
    final String response = await rootBundle.loadString('assets/product_list.json');
    final data = await json.decode(response);
    final list = List<Product>.from(data['product_items'].map((model) => Product.fromJson(model)));
    return list;
  }
}