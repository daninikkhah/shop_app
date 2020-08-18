import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/authentication.dart';
import '../screens/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Authentication _auth = Provider.of<Authentication>(context);
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.route, arguments: product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('images/wow.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () async {
                  try {
                    await product.toggleFavorite(
                        token: _auth.token, userId: _auth.id);
                  } catch (e) {
                    //Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('process failed!')));
                  }
                }),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addItem(
                    id: product.id, price: product.price, title: product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: const Text('product added'),
                    action: SnackBarAction(
                        label: 'undo', onPressed: () => cart.undo()),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
