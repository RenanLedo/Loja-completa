import 'package:flutter/material.dart';
import 'package:loja_completa/components/app_drawer.dart';
import 'package:loja_completa/components/order_widget.dart';
import 'package:loja_completa/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPages extends StatelessWidget {
  const OrdersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderList orders = Provider.of(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.orderCount,
        itemBuilder: (ctx, i) => OrderWidget(
          order: orders.items[i],
        ),
      ),
    );
  }
}
