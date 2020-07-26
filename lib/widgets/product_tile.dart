import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  ProductTile(
      {@required this.id, @required this.title, @required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.route, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
