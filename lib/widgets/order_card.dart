import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart';
import '../models/cart_item.dart';

class OrderCard extends StatefulWidget {
  OrderCard({@required this.order});
  final OrderItem order;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final List<CartItem> items = widget.order.products;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: isExpanded
          ? items.length > 2 ? 350.0 : 120 + items.length * 80.0
          : 110,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.time)),
              trailing: IconButton(
                  icon:
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  }),
            ),
            if (isExpanded)
              Divider(
                thickness: 2,
              ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              //height: 200,
              height: isExpanded
                  ? items.length > 2 ? 240.0 : items.length * 80.0
                  : 0,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) => ListTile(
                        title: Text(items[i].title),
                        subtitle: Text('\$${items[i].price}'),
                        trailing: Text('${items[i].quantity} X'),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
