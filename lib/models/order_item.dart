import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class OrderItem {
  OrderItem(
      {@required this.id,
      @required this.products,
      @required this.amount,
      @required this.time});
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime time;
}
