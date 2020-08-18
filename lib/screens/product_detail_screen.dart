import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/product_detail_screen.dart';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final Product product =
        Provider.of<ProductsProvider>(context, listen: false)
            .getProductWhere(id: id);
    return Scaffold(
//        appBar: AppBar(
//          title: Text(product.title),
//        ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              color: Colors.black54,
              child: Text(product.title),
            ),
            background: Hero(
              tag: product.id,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${product.price}',
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  product.description,
                  softWrap: true,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 600,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
