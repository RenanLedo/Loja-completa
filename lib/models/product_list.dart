import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/data/dummy_data.dart';
import 'package:loja_completa/models/product.dart';

class ProductList extends ChangeNotifier {
  final baseUrl = 'https://loja-cod3r-ec2df-default-rtdb.firebaseio.com';

  List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens];
  List<Product> get itensFavorite =>
      _itens.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _itens.length;
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
    final response = await http.post(Uri.parse('$baseUrl/product.json'),
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

  Future<void> upDateProduct(Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
    return Future.value();
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
