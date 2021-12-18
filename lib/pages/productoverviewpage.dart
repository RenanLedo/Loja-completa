import 'package:flutter/material.dart';
import 'package:loja_completa/components/product_grid.dart';

enum FiltroProduct {
  All,
  Favotitos,
}

class Productoverviewpage extends StatefulWidget {
  Productoverviewpage({Key? key}) : super(key: key);

  @override
  _ProductoverviewpageState createState() => _ProductoverviewpageState();
}

class _ProductoverviewpageState extends State<Productoverviewpage> {
  bool _showFavorite = false;
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
                value: FiltroProduct.Favotitos,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FiltroProduct.All,
              ),
            ],
            onSelected: (FiltroProduct selecionado) {
              setState(() {
                if (selecionado == FiltroProduct.Favotitos) {
                  _showFavorite = true;
                } else if (selecionado == FiltroProduct.All) {
                  _showFavorite = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGrid(showFavorite: _showFavorite),
    );
  }
}
