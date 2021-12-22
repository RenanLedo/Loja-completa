import 'package:flutter/material.dart';
import 'package:loja_completa/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Minha Loja'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Loja'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Pedidos'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDER);
            },
          ),
        ],
      ),
    );
  }
}
