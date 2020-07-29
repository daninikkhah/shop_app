import 'package:flutter/foundation.dart';

import '../models/order_item.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];
  void addOrder({List<CartItem> items, double totalAmount}) {
    _orders.add(OrderItem(
        id: DateTime.now().toString(),
        products: items,
        amount: totalAmount,
        time: DateTime.now()));
    notifyListeners();
  }
}
