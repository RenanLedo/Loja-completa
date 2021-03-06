import 'package:flutter/material.dart';
import 'package:loja_completa/components/app_drawer.dart';
import 'package:loja_completa/components/product_tile_gerenciador_widget.dart';
import 'package:loja_completa/models/product_list.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  Future<void> refreshProduct(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    ProductList product = Provider.of(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Gerenciador de Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: product.itemsCount,
            itemBuilder: (cts, i) => ProductTileGerenciadorWidget(
              product: product.itens[i],
            ),
          ),
        ),
      ),
    );
  }
}
