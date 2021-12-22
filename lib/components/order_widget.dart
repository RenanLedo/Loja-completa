import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:loja_completa/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool expandir = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.order.total.toStringAsFixed(2)),
            subtitle: Text(
              DateFormat('dd/MM/yyyy - hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: expandir
                  ? Icon(
                      Icons.expand_less_rounded,
                    )
                  : Icon(
                      Icons.expand_more,
                    ),
              onPressed: () {
                setState(() {
                  expandir = !expandir;
                });
              },
            ),
          ),
          if (expandir)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: widget.order.products.length * 25 + 10,
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text('${product.quantidade} x R\$ ${product.price}')
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
