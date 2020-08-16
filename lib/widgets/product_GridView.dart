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
    print('ProductGridView');

    final List<Product> products = showAll
        ? Provider.of<ProductsProvider>(context, listen: false).productsList
        : Provider.of<ProductsProvider>(context, listen: false)
            .favoriteProducts;
    products ?? print('NNNUUUUUUUUUUUUUULLLLL');
    print(products);
    print(products.length);
    products.forEach((p) {
      print(p.title);
    });
    print('end//////////////////////////////////////////////');
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
