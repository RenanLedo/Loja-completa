import 'package:flutter/material.dart';
import 'package:loja_completa/models/product.dart';

class ProductDetalhePage extends StatelessWidget {
  const ProductDetalhePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Container(),
    );
  }
}
