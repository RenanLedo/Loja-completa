import 'package:flutter/material.dart';
import 'package:loja_completa/components/app_drawer.dart';
import 'package:loja_completa/components/order_widget.dart';
import 'package:loja_completa/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPages extends StatefulWidget {
  const OrdersPages({Key? key}) : super(key: key);

  @override
  State<OrdersPages> createState() => _OrdersPagesState();
}

class _OrdersPagesState extends State<OrdersPages> {
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() => _isloading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderList orders = Provider.of(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.orderCount,
              itemBuilder: (ctx, i) => OrderWidget(
                order: orders.items[i],
              ),
            ),
    );
  }
}
