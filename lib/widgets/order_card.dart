import 'package:flutter/material.dart';
import '../models/order_item.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  OrderCard({@required this.order});
  final OrderItem order;
  @override
  Widget build(BuildContext context) {
    print(order.id);
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text('\$${order.amount.toStringAsFixed(2)}'),
        subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(order.time)),
        trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: null),
      ),
    );
  }
}
