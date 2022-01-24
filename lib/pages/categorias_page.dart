import 'package:flutter/material.dart';
import 'package:loja_completa/components/app_drawer.dart';
import 'package:loja_completa/components/categoria_tile_gerencia.dart';
import 'package:loja_completa/models/categoria_lista.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({Key? key}) : super(key: key);

  Future<void> refreshProduct(BuildContext context) {
    return Provider.of<CategoriaLista>(context, listen: false).loadCategorias();
  }

  @override
  Widget build(BuildContext context) {
    CategoriaLista categoria = Provider.of(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Gerenciador de Categorias'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.CAT_FORM);
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
            itemCount: categoria.items.length,
            itemBuilder: (cts, i) => CategoriaTileGerencia(
              categoria: categoria.items[i],
            ),
          ),
        ),
      ),
    );
  }
}
