import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  //Map<CartItem, String> _itemsMap = {};
  List<CartItem> get items => [..._items];

  int get count => _items.length;

  double get totalAmount {
    double sum = 0;
    _items.forEach((item) {
      sum += (item.price * item.quantity);
      print(sum);
    });
    return sum;
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  addItem({String id, double price, String title}) {
    _items.any((item) => item.id == id)
        ? _items.firstWhere((item) => item.id == id).quantity++
        : _items.add(CartItem(id: id, title: title, price: price, quantity: 1));
    notifyListeners();
  }
}
