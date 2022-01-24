import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/product.dart';

class ProductDetalhePage extends StatelessWidget {
  const ProductDetalhePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            elevation: 5,
            onPressed: () {
              cart.addItem(product);
            },
            label: Consumer<Cart>(
              builder: (_, cart, __) {
                return Text('Adicionar');
              },
            ),
            icon: Icon(Icons.shopping_cart),
          ),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  snap: true,
                  floating: true,
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  pinned: true,
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${product.price.toString()}',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            // Row(
                            //   children: [
                            //     BotaoIcone(
                            //       padding: 5,
                            //       icone: Icons.remove,
                            //       cor: Colors.black,
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 20),
                            //       child:
                            //           Text('1', style: TextStyle(fontSize: 25)),
                            //     ),
                            //     BotaoIcone(
                            //       padding: 5,
                            //       icone: Icons.add,
                            //       cor: Colors.black,
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ],
        ));
  }
}
