import 'package:flutter/material.dart';
import 'package:loja_completa/components/product_grid.dart';

class Productoverviewpage extends StatelessWidget {
  Productoverviewpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}
