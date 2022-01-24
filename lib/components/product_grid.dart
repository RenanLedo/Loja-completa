import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_completa/components/product_tile-item.dart';
import 'package:loja_completa/models/product.dart';
import 'package:loja_completa/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorite;

  ProductGrid({
    required this.showFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavorite ? provider.favoriteItems : provider.itens;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductTileItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
