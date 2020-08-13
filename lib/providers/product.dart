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

  Future<void> toggleFavorite({String token, String userId}) async {
    String url =
        'https://shop-app-f609c.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    bool favoriteState = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      var response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        isFavorite = favoriteState;
        notifyListeners();
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      isFavorite = favoriteState;
      notifyListeners();
      throw e;
    }
//    print(isFavorite);
  }
}
