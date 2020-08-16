import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_GridView.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import './app_drawer.dart';

enum ProductFilter { all, favorites }

class ProductOverviewScreen extends StatefulWidget {
  static const String route = 'shop_app/screens/product_overview_screen.dart';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool bShowAll = true;
  bool isLoading = false;
  bool run = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (run) {
      print('didChangeDependencies');
      isLoading = true;
      Provider.of<ProductsProvider>(context)
          .fetchProductsFromServer()
          .then((_) => isLoading = false);
      run = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building ProductOverviewScreen');
    final Cart cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
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
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                },
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGridView(
              showAll: bShowAll,
            ),
    );
  }
}
