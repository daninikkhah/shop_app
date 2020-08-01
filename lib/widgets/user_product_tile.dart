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
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () async {
                      bool condition;
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are you sure?'),
                              titleTextStyle: TextStyle(color: Colors.black),
                              content:
                                  Text('Do you want to delete the product?'),
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
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product deleted!'),
                          ),
                        );
                        Provider.of<ProductsProvider>(context, listen: false)
                            .deleteProduct(id);
                      }
                    })
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
