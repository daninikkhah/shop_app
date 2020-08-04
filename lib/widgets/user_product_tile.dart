import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductTile extends StatelessWidget {
  UserProductTile(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.price});
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  void _delete({BuildContext context, ScaffoldState scaffold}) async {
    bool condition;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            titleTextStyle: TextStyle(color: Colors.black),
            content: Text('Do you want to delete the product?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    condition = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes!')),
              FlatButton(
                  onPressed: () {
                    condition = false;
                    Navigator.of(context).pop();
                  },
                  child: Text('No!')),
            ],
          );
        });
    if (condition) {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .deleteProduct(id);
        scaffold.hideCurrentSnackBar();
        scaffold.showSnackBar(
          SnackBar(
            content: Text(
                'product deleted successfully!'), //todo show after deleting
          ),
        );
      } catch (e) {
        scaffold.hideCurrentSnackBar();
        scaffold.showSnackBar(
          SnackBar(
            content: Text('product deleting failed!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text('\$$price'),
          trailing: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.mode_edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProductScreen.route, arguments: id);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () =>
                        _delete(context: context, scaffold: scaffold))
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
