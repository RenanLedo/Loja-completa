import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      notifyListeners();
    }

    print(body);
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
      notifyListeners();
    }

    print(body);
  }
}