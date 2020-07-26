import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_tile.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductsProvider>(context).products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, i) => ProductTile(
        id: products[i].id,
        title: products[i].title,
        imageUrl: products[i].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
