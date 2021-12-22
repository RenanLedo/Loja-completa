import 'package:flutter/material.dart';
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/cart_item.dart';
import 'package:provider/provider.dart';

class ItemCartWidget extends StatelessWidget {
  final CartItem cart;

  const ItemCartWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var total = cart.price * cart.quantidade;
    return Dismissible(
      key: ValueKey(cart.id),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(cart.productId);
      },
      child: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          cart.imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    cart.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('${cart.quantidade} x ${cart.price.toString()}'),
                ],
              ),
              Text('Total ${total.toStringAsFixed(2)}'),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // cart.quant;
                        Provider.of<Cart>(context, listen: false)
                            .removeSingleItem(cart.productId);
                      },
                      icon: Icon(
                        cart.quantidade == 1 ? Icons.delete : Icons.remove,
                        color: Colors.red,
                      )),
                  Text(cart.quantidade.toString()),
                  IconButton(
                      onPressed: () {
                        // cart.quant;
                        Provider.of<Cart>(context, listen: false)
                            .addSingleItem(cart.productId);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
