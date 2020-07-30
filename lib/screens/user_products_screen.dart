import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './app_drawer.dart';
import '../widgets/user_product_tile.dart';
import '../providers/products_provider.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/user_products_screen.dart';
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
      body: Consumer<ProductsProvider>(
        builder: (context, productsProvider, child) => ListView.builder(
          itemCount: productsProvider.products.length,
          itemBuilder: (context, i) => UserProductTile(
              title: productsProvider.products[i].title,
              imageUrl: productsProvider.products[i].imageUrl),
        ),
      ),
    );
  }
}
