import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

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
  bool isLoading = false;
  Product product;
  String id;
  String title;
  String description;
  String url;
  double price;
  bool isFavorite;
  bool run = false;

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

  void _submitForm() async {
    if (_form.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _form.currentState.save();
      try {
        id == null
            ? await Provider.of<ProductsProvider>(context, listen: false)
                .addProduct(
                title: title,
                description: description,
                imageUrl: url,
                price: price,
              )
            : await Provider.of<ProductsProvider>(context, listen: false)
                .updateProduct(
                id: id,
                title: title,
                description: description,
                imageUrl: url,
                price: price,
                isFavorite: isFavorite,
              );
      } on Exception catch (_) {
        setState(() {
          isLoading = false;
        });
        await showDialog<Null>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('An error occurred'),
            content: const Text('something gone wrong!'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('OK'),
              ),
              //todo add retry
            ],
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
    //todo
  }

  @override
  Widget build(BuildContext context) {
    if (!run) {
      id = ModalRoute.of(context).settings.arguments as String;
      run = true;
    }

    if (id != null) {
      final Product currentProduct =
          Provider.of<ProductsProvider>(context, listen: false)
              .getProductWhere(id: id);
      id = currentProduct.id;
      title = currentProduct.title;
      description = currentProduct.description;
      url = currentProduct.imageUrl;
      price = currentProduct.price;
      isFavorite = currentProduct.isFavorite;
      _imageUrlTextController.text = url;
    }

    final double size = MediaQuery.of(context).size.width / 5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _submitForm)],
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.save), onPressed: _submitForm),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: title,
                        decoration: InputDecoration(
                          labelText: 'title',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            value.isEmpty ? 'please enter a title name.' : null,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (value) {
                          title = value;
                        },
                      ),
                      TextFormField(
                        initialValue: price == null ? '' : price.toString(),
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
                        initialValue: description,
                        decoration: InputDecoration(
                          labelText: 'description',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) => value.isEmpty
                            ? 'please enter the description.'
                            : null,
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
