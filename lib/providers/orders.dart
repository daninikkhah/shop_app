import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_item.dart';
import '../models/cart_item.dart';

const String url = 'https://shop-app-f609c.firebaseio.com/orders.json';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];

  Future<void> addOrder({List<CartItem> items, double totalAmount}) async {
    final DateTime time = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'items': items
              .map((cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'price': cartItem.price,
                  })
              .toList(),
          'totalAmount': totalAmount,
          'time': time.toIso8601String(),
        }),
      );
      String id = json.decode(response.body)['id'];
      _orders.add(
        OrderItem(id: id, products: items, amount: totalAmount, time: time),
      );
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
