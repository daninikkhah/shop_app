import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_card.dart';
import '../providers/orders.dart';
import './orders_screen.dart';

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
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 20),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ShoppingIconButton(cart: cart)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.count,
              itemBuilder: (context, i) => CartCard(
//                id: cart.items[i].id,
//                title: cart.items[i].title,
//                price: cart.items[i].price,
//                quantity: cart.items[i].quantity,
                cartItem: cart.items[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShoppingIconButton extends StatefulWidget {
  const ShoppingIconButton({
    @required this.cart,
  });

  final Cart cart;

  @override
  _ShoppingIconButtonState createState() => _ShoppingIconButtonState();
}

class _ShoppingIconButtonState extends State<ShoppingIconButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: widget.cart.totalAmount <= 0
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
            ),
            onPressed: widget.cart.totalAmount <= 0
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final Orders orders =
                        Provider.of<Orders>(context, listen: false);
                    try {
                      await orders.addOrder(
                          items: widget.cart.items,
                          totalAmount: widget.cart.totalAmount);
                      widget.cart.clear();
                      Navigator.of(context).pushNamed(OrdersScreen.route);
                    } catch (e) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('order failed!'),
                        ),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  });
  }
}
