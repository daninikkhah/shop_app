import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

const String url = 'https://shop-app-f609c.firebaseio.com/products';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  //TODO add update method to react to Product changes
  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }



  Product getProductWhere({String id}) {
    return products.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(
      {String title, String description, String imageURl, double price}) {
    return http
        .post(
      url,
      body: json.encode({
        'title': title,
        'description': description,
        'imageURl': imageURl,
        'price': price,
        'isFavorite': false,
      }),
    )
        .then((response) {
      _products.add(Product(
          id: json.decode(response.body)['name'],
          title: title,
          description: description,
          imageUrl: imageURl,
          price: price));
      notifyListeners();
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  void updateProduct(
      {String id,
      String title,
      String description,
      String imageURl,
      double price,
      bool isFavorite}) {
    int index = _products.indexWhere((product) => product.id == id);
    _products[index] = Product(
      id: id,
      title: title,
      description: description,
      imageUrl: imageURl,
      price: price,
      isFavorite: isFavorite,
    );
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
