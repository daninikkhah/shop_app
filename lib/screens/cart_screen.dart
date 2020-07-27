import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/cart_screen.dart';

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 16),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
