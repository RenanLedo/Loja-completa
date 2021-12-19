import 'package:flutter/material.dart';
import 'package:loja_completa/models/cart_item.dart';

class ItemCartWidget extends StatelessWidget {
  final CartItem cart;

  const ItemCartWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        cart.imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                Text('${cart.quantidade} x ${cart.price.toString()}'),
              ],
            ),
            Text(cart.name),
            Text('Total ${cart.price * cart.quantidade}'),
          ],
        ),
      ),
    );
  }
}