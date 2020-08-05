import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';
import '../models/http_exception.dart';

const String url = 'https://shop-app-f609c.firebaseio.com/products.json';

class ProductsProvider with ChangeNotifier {
  List<Product> _productsList = [];

  //TODO add update method to react to Product changes
  List<Product> get productsList {
    return [..._productsList];
  }

  List<Product> get favoriteProducts {
    return _productsList.where((product) => product.isFavorite).toList();
  }

  Future<void> getDateFromServer() async {
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> _serverProducts = [];

      extractedData.forEach((productID, productData) {
        _serverProducts.add(
          Product(
            id: productID,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      _productsList = _serverProducts;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Product getProductWhere({String id}) {
    return _productsList.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(
      {String title, String description, String imageUrl, double price}) {
    return http
        .post(
      url,
      body: json.encode({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
        'isFavorite': false,
      }),
    )
        .then((response) {
      _productsList.add(Product(
          id: json.decode(response.body)['name'],
          title: title,
          description: description,
          imageUrl: imageUrl,
          price: price));
      notifyListeners();
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  Future<void> updateProduct(
      {String id,
      String title,
      String description,
      String imageUrl,
      double price,
      bool isFavorite}) async {
    int index = _productsList.indexWhere((product) => product.id == id);
    Product rollBackProduct = _productsList[index];

    final String productUrl =
        'https://shop-app-f609c.firebaseio.com/products/$id.json';
    _productsList[index] = Product(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      price: price,
      isFavorite: isFavorite,
    );
    notifyListeners();
    var response = await http.patch(
      productUrl,
      body: json.encode({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
      }),
    );
    if (response.statusCode >= 400) {
      _productsList[index] = rollBackProduct;
      notifyListeners();
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    final String productUrl =
        'https://shop-app-f609c.firebaseio.com/products/$id.json';
    int index = _productsList.indexWhere((product) => product.id == id);
    Product deletedProduct = _productsList[index];
    notifyListeners();
    _productsList.removeAt(index);
    notifyListeners();
    var response = await http.delete(productUrl);
    if (response.statusCode >= 400) {
      _productsList.insert(index, deletedProduct);
      notifyListeners();
      deletedProduct = null; //this way dart will remove instance of product
      throw HttpException(response.toString());
    }
    deletedProduct = null; //will dart  delete deletedProduct??
  }
}
