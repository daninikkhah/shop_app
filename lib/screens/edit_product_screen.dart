import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = 'shop_app/screens/edit_product_screen.dart';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: SafeArea(
          child: Form(
              child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'title',
              ),
              textInputAction: TextInputAction.next,
            )
          ],
        ),
      ))),
    );
  }
}
