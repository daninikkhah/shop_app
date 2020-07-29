import 'package:flutter/material.dart';
import './product_overview_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.route);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
