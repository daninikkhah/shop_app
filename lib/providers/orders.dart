import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_item.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];

  String url = 'https://shop-app-f609c.firebaseio.com/orders.json';

  void getAuthToken(String token) {
    url = 'https://shop-app-f609c.firebaseio.com/orders.json?auth=$token';
    notifyListeners();
  }

  //todo add exception handling
  Future<void> fetchOrdersFromServer() async {
    var response = await http.get(url);
    Map<String, dynamic> extractedData = json.decode(response.body);
    List<OrderItem> loadedOrders = [];
    if (extractedData != null)
      extractedData.forEach(
        (id, orderData) {
          loadedOrders.add(OrderItem(
            id: id,
            amount: orderData['totalAmount'],
            time: DateTime.parse(orderData['time']),
            products: (orderData['items'] as List<dynamic>)
                .map(
                  (productDate) => CartItem(
                      id: productDate['id'],
                      title: productDate['title'],
                      price: productDate['price'],
                      quantity: productDate['quantity']),
                )
                .toList(),
          ));
        },
      );
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

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
                    'quantity': cartItem.quantity
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
