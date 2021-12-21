import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/order.dart';

class OrderList extends ChangeNotifier {
  List<Order> _items = [];
  List<Order> get items => [..._items];

  int get orderCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: DateTime.now(),
        ));
    notifyListeners();
  }
}
