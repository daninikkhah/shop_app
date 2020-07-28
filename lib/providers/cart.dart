import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  //Map<CartItem, String> _itemsMap = {};
  List<CartItem> get items => [..._items];

  int get count => _items.length;

  double get totalAmount {
    //print(
    //    '/////////////////////////////////******************************/////////////////////////////////');
    double sum = 0;
    _items.forEach((item) {
      //  print('/////////////////////////////////');
      //  print(
      //      'price: ${item.price}, quantity: ${item.quantity}, price*quantity:${item.price * item.quantity}, sum : ${sum + item.price * item.quantity.toDouble()}');
      //  print('/////////////////////////////////');
      sum += item.price * item.quantity;
    });
    return sum;
  }

  void removeItem(String id) {
    //print(
    //   '/////////////////////////////////******************************/////////////////////////////////');
    _items.removeWhere((item) => item.id == id);
    _items.forEach((item) {
      //  print(
      //      'price: ${item.price}, quantity: ${item.quantity}, price*quantity:${item.price * item.quantity}');
    });
    notifyListeners();
  }

  addItem({String id, double price, String title}) {
    _items.any((item) => item.id == id)
        ? _items.firstWhere((item) => item.id == id).quantity++
        : _items.add(CartItem(id: id, title: title, price: price, quantity: 1));
    notifyListeners();
  }
}
