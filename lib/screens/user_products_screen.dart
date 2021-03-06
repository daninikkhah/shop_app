import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './app_drawer.dart';
import '../widgets/user_product_tile.dart';
import '../providers/products_provider.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/user_products_screen.dart';

  Future<void> _refreshProducts(BuildContext context) =>
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchProductsFromServer(filterByCreator: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.route);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (context, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<ProductsProvider>(
                        builder: (context, productsProvider, child) =>
                            ListView.builder(
                          itemCount: productsProvider.productsList.length,
                          itemBuilder: (context, i) => UserProductTile(
                            id: productsProvider.productsList[i].id,
                            title: productsProvider.productsList[i].title,
                            imageUrl: productsProvider.productsList[i].imageUrl,
                            price: productsProvider.productsList[i].price,
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
