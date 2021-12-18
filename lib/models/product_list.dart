import 'package:flutter/material.dart';
import 'package:loja_completa/data/dummy_data.dart';
import 'package:loja_completa/models/product.dart';

class ProductList extends ChangeNotifier {
  List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens];
  List<Product> get itensFavorite => _itens.where((prod) => prod.isFavorite).toList();
  

  void addProduct(Product product) {
    itens.add(product);
    notifyListeners();
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
