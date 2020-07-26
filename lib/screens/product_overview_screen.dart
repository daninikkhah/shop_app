import 'package:flutter/material.dart';
import '../widgets/product_GridView.dart';

enum ProductFilter { all, favorites }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool bShowAll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outland Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (ProductFilter selected) {
                setState(() {
                  bShowAll = selected == ProductFilter.all ? true : false;
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => const [
                    const PopupMenuItem(
                      child: Text('only favorites'),
                      value: ProductFilter.favorites,
                    ),
                    const PopupMenuItem(
                      child: Text('show all'),
                      value: ProductFilter.all,
                    ),
                  ])
        ],
      ),
      body: ProductGridView(
        showAll: bShowAll,
      ),
    );
  }
}
