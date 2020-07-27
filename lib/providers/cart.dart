import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  Map<CartItem, String> _itemsMap = {};
  get items => [..._items];

  get count => _items.length;

  addItem({String id, double price, String title}) {
    _items.any((item) => item.id == id)
        ? _items.firstWhere((item) => item.id == id).quantity++
        : _items.add(CartItem(id: id, title: title, price: price, quantity: 1));
    notifyListeners();
  }
}
