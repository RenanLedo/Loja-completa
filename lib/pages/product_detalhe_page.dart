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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'R\$ ${product.price.toString()}',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
