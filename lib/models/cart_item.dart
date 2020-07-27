import 'package:flutter/foundation.dart';

class CartItem {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
  final String id;
  final String title;
  final double price;
  int quantity; //todo should it be final?? (this way you can change quantity without building a whole CartItem)
}
