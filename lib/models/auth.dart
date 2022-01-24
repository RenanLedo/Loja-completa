import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_completa/data/store.dart';
import 'package:loja_completa/exceptions/auth_exception.dart';
import 'package:loja_completa/utils/constantes.dart';

class Auth extends ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> cadastro(String email, String senha) async {
    final response = await http.post(
      Uri.parse(Constantes.URL_CADASTRO),
      body: jsonEncode(
          {'email': email, 'password': senha, 'returnSecureToken': true}),
    );
    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      Store.saveMap('userData', {
        'token' : _token,
        'email' : _email,
        'userId' : userId,
        'expiryDate' : _expiryDate!.toIso8601String()
      });
      notifyListeners();
    }

  }

  Future<void> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse(Constantes.URL_LOGIN),
      body: jsonEncode(
          {'email': email, 'password': senha, 'returnSecureToken': true}),
    );
    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      Store.saveMap('userData', {
        'token' : _token,
        'email' : _email,
        'userId' : userId,
        'expiryDate' : _expiryDate!.toIso8601String()
      });
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;

    notifyListeners();
  }

  void deslogar() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
