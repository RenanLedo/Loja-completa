import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/utils/constantes.dart';

class Product extends ChangeNotifier {
  String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _togglefavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> togglefavorite(String token) async {
    try {
      _togglefavorite();
      final response =
          await http.patch(Uri.parse('${Constantes.PRODUCT_BASE_URL}/$id.json?auth=$token'),
              body: jsonEncode({
                'isFavorite': isFavorite,
              }));
      if (response.statusCode >= 400) {
        _togglefavorite();
      }
    } catch (e) {
      _togglefavorite();
    }
  }
}
