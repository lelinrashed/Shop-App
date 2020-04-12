import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourit;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourit = false,
  });

  void _setFavValue(bool newValue) {
    isFavourit = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouritStatus(String token) async {
    final url = 'https://flutter-shop-53320.firebaseio.com/products/$id.json?auth=$token';
    final oldStatus = isFavourit;
    isFavourit = !isFavourit;
    notifyListeners();
    try {
      final response = await http.patch(url, body: json.encode({
        'isFavourit': isFavourit
      }));

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }

    } catch(error) {
      _setFavValue(oldStatus);
    }
  }

}