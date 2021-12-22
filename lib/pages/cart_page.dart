import 'package:flutter/material.dart';
import 'package:loja_completa/components/item_cart_widget.dart';
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/order_list.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final item = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    label: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                  ),
                  Spacer(),
                  // Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false)
                          .addOrder(cart);
                      cart.clear();
                    },
                    child: Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (cxt, i) => ItemCartWidget(cart: item[i]),
            ),
          ),
        ],
      ),
    );
  }
}
