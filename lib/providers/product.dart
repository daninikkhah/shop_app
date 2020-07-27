import 'package:flutter/foundation.dart';

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    print('notifyListeners');
    notifyListeners();
//    print(isFavorite);
  }
}
