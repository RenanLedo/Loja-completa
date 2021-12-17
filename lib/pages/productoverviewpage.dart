import 'package:flutter/material.dart';
import 'package:loja_completa/components/product_grid.dart';

class Productoverviewpage extends StatelessWidget {
  Productoverviewpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ProductGrid(),
    );
  }
}
