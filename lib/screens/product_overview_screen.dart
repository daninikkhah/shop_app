import 'package:flutter/material.dart';
import '../models/product.dart';
import '../dummy_data.dart';
import '../widgets/product_tile.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outland Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, i) => ProductTile(
          title: products[i].title,
          imageUrl: products[i].imageUrl,
        ),
        itemCount: products.length,
      ),
    );
  }
}
