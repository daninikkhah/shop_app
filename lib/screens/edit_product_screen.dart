import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String route = 'shop_app/screens/edit_product_screen.dart';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlTextController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Product product;
  String title;
  String description;
  String url;
  double price;

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlTextController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(_updateUrl);
  }

  void _updateUrl() {
    setState(() {});
    //if (_imageUrlTextController.text.isNotEmpty) setState(() {});
  }

  void _submitForm() {
    if (_form.currentState.validate()) _form.currentState.save();
    //todo
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _submitForm)],
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.save), onPressed: _submitForm),
      body: SafeArea(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value.isEmpty ? 'please enter a title name.' : null,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: (value) {
                    title = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if (value.isEmpty) return 'please enter the price.';
                    if (double.tryParse(value) == null)
                      return 'please enter a valid number.';
                    if (double.parse(value) <= 0)
                      return 'please enter a number greater than zero.';
                    return null;
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: (value) {
                    price = double.parse(value);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) =>
                      value.isEmpty ? 'please enter the description.' : null,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    description = value;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 15),
                      width: size, //todo
                      height: size,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      )),
                      child: _imageUrlTextController.text.isEmpty
                          ? Center(child: Text('no image'))
                          : Image.network(
                              _imageUrlTextController.text,
                              fit: BoxFit.cover,
                            ), //todo
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlTextController,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) =>
                            value.isEmpty ? 'please enter a url.' : null,
                        onSaved: (value) {
                          url = value;
                        },
                        onFieldSubmitted: (_) {
                          _submitForm();
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
