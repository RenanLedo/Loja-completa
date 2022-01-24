import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/cart_item.dart';
import 'package:loja_completa/models/order.dart';
import 'package:loja_completa/utils/constantes.dart';

class OrderList extends ChangeNotifier {
  String _token;
  String _userId;
  List<Order> _items = [];
  List<Order> get items => [..._items];

  OrderList(this._token, this._items, this._userId);

  int get orderCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];
    final response = await http.get(
        Uri.parse('${Constantes.ORDER_BASE_URL}/$_userId.json?auth=$_token'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(Order(
        id: orderId,
        date: DateTime.parse(orderData['date']),
        total: orderData['total'],
        products: (orderData['product'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            imageUrl: item['imageUrl'],
            name: item['name'],
            price: item['price'],
            productId: item['productId'],
            quantidade: item['quantidade'],
          );
        }).toList(),
      ));
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
        Uri.parse('${Constantes.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
        body: jsonEncode({
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'product': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'imageUrl': cartItem.imageUrl,
                    'quantidade': cartItem.quantidade,
                    'price': cartItem.price
                  })
              .toList()
        }));
    final id = jsonDecode(response.body)['name'];
    _items.insert(
        0,
        Order(
          id: id,
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: date,
        ));
    notifyListeners();
  }
}
