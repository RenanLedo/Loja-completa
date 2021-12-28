import 'package:flutter/material.dart';

import 'package:loja_completa/models/product.dart';
import 'package:loja_completa/models/product_list.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductTileGerenciadorWidget extends StatelessWidget {
  final Product product;
  const ProductTileGerenciadorWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Quer Excluir?'),
                    content: Text(
                        'Tenha certeza que deseja excluir esse produto definitivamente?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(context, listen: false)
                              .removeProduct(product);
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
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
