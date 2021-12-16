import 'package:flutter/material.dart';
import 'package:loja_completa/components/product_tile-item.dart';
import 'package:loja_completa/data/dummy_data.dart';
import 'package:loja_completa/models/product.dart';

class Productoverviewpage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  Productoverviewpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, i) => ProductTileItem(
          product: loadedProducts[i],
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: loadedProducts.length,
      ),
    );
  }
}
