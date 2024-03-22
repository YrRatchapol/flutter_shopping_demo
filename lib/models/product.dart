import 'package:intl/intl.dart';

class Product {
  late final int id;
  late final String name;
  late final String description;
  late final String imageUrl;
  late final double price;

  bool isFavorite = false;

  String get formattedPrice {
    return NumberFormat.simpleCurrency(locale: 'th_TH').format(price);
  }

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        imageUrl = json['image_url'],
        price = json['price'];
}