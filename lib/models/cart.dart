
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_completa/models/cart_item.dart';
import 'package:loja_completa/models/product.dart';

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantidade;
    });
    return total;
  }

  int get quant {
    var quantItensCart;
    _items.forEach((key, value) {
      quantItensCart = value.quantidade;
    });
    return quantItensCart;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existeItem) => CartItem(
          id: existeItem.id,
          productId: existeItem.productId,
          name: existeItem.name,
          quantidade: existeItem.quantidade + 1,
          price: existeItem.price,
          imageUrl: existeItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantidade: 1,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  // void acrescentar(int valor) {
  //   _items.forEach((key, value) {
  //     valor = value.quantidade + 1;
  //   });
  //   notifyListeners();
  // }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantidade == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existeItem) => CartItem(
          id: existeItem.id,
          productId: existeItem.productId,
          name: existeItem.name,
          quantidade: existeItem.quantidade - 1,
          price: existeItem.price,
          imageUrl: existeItem.imageUrl,
        ),
      );
    }

    notifyListeners();
  }

  void addSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else {
      _items.update(
        productId,
        (existeItem) => CartItem(
          id: existeItem.id,
          productId: existeItem.productId,
          name: existeItem.name,
          quantidade: existeItem.quantidade + 1,
          price: existeItem.price,
          imageUrl: existeItem.imageUrl,
        ),
      );
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
