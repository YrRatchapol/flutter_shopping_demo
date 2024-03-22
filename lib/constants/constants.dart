import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_demo/scenes/product_list/product_list_page.dart';
import 'package:shopping_demo/scenes/tracking_list/tracking_list_page.dart';

class Constants {
  static final List<Widget> bottomBarPages = [
    const ProductListPage(),
    const TrackingListPage(),
    // const CartPage(),
  ];

  static List<BottomNavigationBarItem> bottomBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.format_align_left), label: 'Tracking'),
    // const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'Cart'),
  ];
}