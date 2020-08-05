import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/order_card.dart';
import './app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/orders_screen.dart';

  @override
  Widget build(BuildContext context) {
    //final Orders orders = Provider.of<Orders>(context);todo delete
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false)
              .fetchOrdersFromServer(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (dataSnapshot.error != null)
              return Center(
                child: Text('Something went wrong!'),
              );
            return Consumer<Orders>(
              builder: (context, orders, child) => ListView.builder(
                itemCount: orders.orders.length,
                itemBuilder: (context, i) => OrderCard(order: orders.orders[i]),
              ),
            );
          }),
    );
  }
}
