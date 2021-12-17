import 'package:flutter/material.dart';
import 'package:loja_completa/data/dummy_data.dart';
import 'package:loja_completa/models/product.dart';

class ProductList extends ChangeNotifier {
  List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens]; 

  void addProduct(Product product){
    itens.add(product);
    notifyListeners();
  }
}