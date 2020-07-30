import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../models/cart_item.dart';

class CartCard extends StatelessWidget {
  CartCard({
//    @required this.title,
//    @required this.price,
//    @required this.quantity,
//    @required this.id,
    @required this.cartItem,
  });
  final CartItem cartItem;
//  final String id;
//  final String title;
//  final double price;
//  final int quantity;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        cart.removeItem(cartItem.id);
      },
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Are you sure?',
            style: TextStyle(color: Colors.black),
          ),
          content: Text('Do you want to remove the item from the cart?'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes')),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No')),
          ],
        ),
      ),
      background: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete_sweep,
          size: 30,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
            child: FittedBox(
              //fit: BoxFit.cover,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text('\$${cartItem.price}'),
              ),
            ),
          ),
          title: Text(cartItem.title),
          subtitle: Text('${cartItem.quantity.toString()} X'),
          trailing: Text(
            '\$${(cartItem.quantity * cartItem.price).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
