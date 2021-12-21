import 'package:flutter/material.dart';
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/product.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductTileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.PRODTUC_DETAIL, arguments: product);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(product.name),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product);
                print(cart.itemCount);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  product.togglefavorite();
                },
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
          //
          // Container(
          //   color: Colors.black54,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.shopping_bag,
          //           color: Colors.red,
          //         ),
          //       ),
          //       Text(
          //         product.name,
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.shopping_bag,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
