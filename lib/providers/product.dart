import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  //todo add exception handling
  Future<void> toggleFavorite(String token) async {
    String url =
        'https://shop-app-f609c.firebaseio.com/products/$id.json?auth=$token';
    isFavorite = !isFavorite;
    notifyListeners();
    var response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException(response.statusCode.toString());
    }
//    print(isFavorite);
  }
}
