import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_GridView.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';

enum ProductFilter { all, favorites }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool bShowAll = true;
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context, listen: false);
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
                  ]),
          Consumer<Cart>(
            builder: (context, ch, _) => Badge(
              value: cart.count,
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                },
              ),
            ),
          )
        ],
      ),
      body: ProductGridView(
        showAll: bShowAll,
      ),
    );
  }
}
