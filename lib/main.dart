import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/providers/product_provider.dart';
import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}