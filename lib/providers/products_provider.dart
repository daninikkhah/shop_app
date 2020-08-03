import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

const String url = 'https://shop-app-f609c.firebaseio.com/products.json';

class ProductsProvider with ChangeNotifier {
  List<Product> _productsList = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

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
              price: productData['price']),
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

    final String patchUrl =
        'https://shop-app-f609c.firebaseio.com/products/$id.json';
    try {
      await http.patch(
        patchUrl,
        body: json.encode({
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'price': price,
        }),
      );

      _productsList[index] = Product(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        price: price,
        isFavorite: isFavorite,
      );
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  void deleteProduct(String id) {
    _productsList.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
