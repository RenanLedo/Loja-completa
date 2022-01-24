import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/exceptions/http_exception.dart';
import 'package:loja_completa/models/product.dart';
import 'package:loja_completa/utils/constantes.dart';

class ProductList extends ChangeNotifier {
  String _token;
  String _userId;
  List<Product> _itens = [];

  List<Product> get itens => [..._itens];
  List<Product> get favoriteItems =>
      _itens.where((prod) => prod.isFavorite).toList();
  

  ProductList(this._token, this._itens, this._userId);

  int get itemsCount {
    return _itens.length;
  }

  // get itensFavorite => null;

  Future<void> loadProducts() async {
    _itens.clear();
    final response = await http
        .get(Uri.parse('${Constantes.PRODUCT_BASE_URL}.json?auth=$_token'));
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('${Constantes.USER_FAVORITE_URL}/$_userId.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : (jsonDecode(favResponse.body));

    

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _itens.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
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
    final response = await http.post(
        Uri.parse('${Constantes.PRODUCT_BASE_URL}.json?auth=$_token'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }));

    final id = jsonDecode(response.body)['name'];
    _itens.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> upDateProduct(Product product) async {
    int index = _itens.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
          Uri.parse(
              '${Constantes.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
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

  Future<void> removeProduct(Product product) async {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _itens[index];
      _itens.remove(product);
      notifyListeners();
      final response = await http.delete(Uri.parse(
          '${Constantes.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'));
      if (response.statusCode >= 400) {
        _itens.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Erro ao excluir produto',
          statusCode: response.statusCode,
        );
      }
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
