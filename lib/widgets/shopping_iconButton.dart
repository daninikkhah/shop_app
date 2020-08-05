import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';

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
