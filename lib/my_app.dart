import 'package:flutter/material.dart';
import 'package:shopping_demo/scenes/main_tabbar/main_tabbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainTabbar(),
    );
  }
}