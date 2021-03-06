import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => [..._items];

  int get count => _items.length;

  double get totalAmount {
    double sum = 0;
    _items.forEach((item) {
      sum += (item.price * item.quantity);
    });
    return sum;
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void undo() {
    _items.last.quantity > 1 ? _items.last.quantity-- : _items.removeLast();
    notifyListeners();
  }

  void addItem({String id, double price, String title}) {
    _items.any((item) => item.id == id)
        ? _items.firstWhere((item) => item.id == id).quantity++
        : _items.add(CartItem(id: id, title: title, price: price, quantity: 1));
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
