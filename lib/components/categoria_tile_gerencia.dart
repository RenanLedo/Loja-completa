import 'package:flutter/material.dart';
import 'package:loja_completa/exceptions/http_exception.dart';
import 'package:loja_completa/models/categoria.dart';
import 'package:loja_completa/models/categoria_lista.dart';

import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CategoriaTileGerencia extends StatelessWidget {
  final Categoria categoria;
  const CategoriaTileGerencia({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(categoria.imageCat),
      ),
      title: Text(categoria.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.CAT_FORM, arguments: categoria);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Quer Excluir?'),
                    content: Text(
                        'Tenha certeza que deseja excluir essa categoria definitivamente?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Excluir'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                    Provider.of<CategoriaLista>(
                        context,
                        listen: false,
                      )..removeCategoraia(categoria);
                    } on HttpException catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
