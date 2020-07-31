import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = 'shop_app/screens/edit_product_screen.dart';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  //final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageTextEditingController =
      TextEditingController();
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
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      width: 100, //todo
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      )),
                      child: _imageTextEditingController.text.isEmpty
                          ? Center(child: Text('no image'))
                          : Image.network(
                              _imageTextEditingController.text,
                              fit: BoxFit.cover,
                            ), //todo
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageTextEditingController,
                        onFieldSubmitted: (_) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
