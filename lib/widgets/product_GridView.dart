import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_tile.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';

class ProductGridView extends StatelessWidget {
  ProductGridView({this.showAll = true});
  final bool showAll;
  @override
  Widget build(BuildContext context) {
    final List<Product> products = showAll
        ? Provider.of<ProductsProvider>(context, listen: false).products
        : Provider.of<ProductsProvider>(context, listen: false)
            .favoriteProducts;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductTile(),
      ),
      itemCount: products.length,
    );
  }
}
