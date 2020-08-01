import 'package:flutter/material.dart';

class UserProductTile extends StatelessWidget {
  UserProductTile(
      {@required this.title, @required this.imageUrl, @required this.price});
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
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: null)
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
