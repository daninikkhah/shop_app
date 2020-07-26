import 'package:flutter/material.dart';

import '../widgets/product_GridView.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outland Shop'),
      ),
      body: ProductGridView(),
    );
  }
}
