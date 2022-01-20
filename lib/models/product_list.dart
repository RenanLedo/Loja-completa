import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/models/product.dart';

class ProductList extends ChangeNotifier {
  final _baseUrl =
      'https://loja-cod3r-ec2df-default-rtdb.firebaseio.com/product';

  List<Product> _itens = [];

  List<Product> get itens => [..._itens];
  List<Product> get itensFavorite =>
      _itens.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _itens.length;
  }

  Future<void> loadProducts() async {
    _itens.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _itens.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return upDateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(Uri.parse('$_baseUrl.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }));

    final id = jsonDecode(response.body)['name'];
    _itens.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> upDateProduct(Product product) async {
    int index = _itens.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(Uri.parse('$_baseUrl/${product.id}.json'),
          body: jsonEncode({
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));

      _itens[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}


// bool _showFavoriteOnly = false;

//   List<Product> get itens {
//     if (_showFavoriteOnly) {
//       return _itens.where((element) => element.isFavorite).toList();
//     }
//     return [..._itens];
//   }

//   void showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }
