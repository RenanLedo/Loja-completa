import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/exceptions/http_exception.dart';
import 'package:loja_completa/models/categoria.dart';
import 'package:loja_completa/utils/constantes.dart';

class CategoriaLista extends ChangeNotifier {
  String _token;
  List<Categoria> _items = [];
  List<Categoria> get items => [..._items];

  CategoriaLista(
    this._token,
    this._items,
  );

  Future<void> loadCategorias() async {
    _items.clear();
    final response = await http
        .get(Uri.parse('${Constantes.PRODUCT_CAT_URL}.json?auth=$_token'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((categoriaId, categoriaData) {
      _items.add(
        Categoria(
          id: categoriaId,
          name: categoriaData['name'],
          imageCat: categoriaData['imageCat'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveCategoria(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final categoria = Categoria(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      imageCat: data['imageCat'] as String,
      name: data['name'] as String,
    );

    if (hasId) {
      print('printando erro 04 add');
      return upDateCategoria(categoria);
    } else {
      return addCategoria(categoria);
    }
  }

  Future<void> addCategoria(Categoria categoria) async {
    print('printando erro 01');
    final response = await http.post(
        Uri.parse('${Constantes.PRODUCT_CAT_URL}.json?auth=$_token'),
        body: jsonEncode({
          'name': categoria.name,
          'imageCat': categoria.imageCat,
        }));
    print('printando erro 02');

    final id = jsonDecode(response.body)['name'];
    _items.add(Categoria(
      id: id,
      name: categoria.name,
      imageCat: categoria.imageCat,
    ));
    print('printando erro 03');
    notifyListeners();
  }

  Future<void> upDateCategoria(Categoria categoria) async {
    int index = _items.indexWhere((p) => p.id == categoria.id);

    if (index >= 0) {
      await http.patch(
          Uri.parse(
              '${Constantes.PRODUCT_CAT_URL}/${categoria.id}.json?auth=$_token'),
          body: jsonEncode({
            'name': categoria.name,
            'imageCat': categoria.imageCat,
          }));

      _items[index] = categoria;
      notifyListeners();
    }
  }

  Future<void> removeCategoraia(Categoria categoria) async {
    int index = _items.indexWhere((p) => p.id == categoria.id);
    if (index >= 0) {
      final categoria = _items[index];
      _items.remove(categoria);
      notifyListeners();
      final response = await http.delete(Uri.parse(
          '${Constantes.PRODUCT_CAT_URL}/${categoria.id}.json?auth=$_token'));
      if (response.statusCode >= 400) {
        _items.insert(index, categoria);
        notifyListeners();
        throw HttpException(
          msg: 'Erro ao excluir categoria',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
