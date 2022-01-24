import 'package:flutter/material.dart';
import 'package:loja_completa/models/auth.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Minha Loja'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Loja'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Pedidos'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDER);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Produtos'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.PRODUCT_PAGE);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Categorias'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.CATEGORIAS);
            },
          ),
          Divider(),
          auth.isAuth
              ? ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Sair'),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: () {
                    auth.deslogar();
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                  },
                )
              : ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Login'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
                  },
                ),
          Divider(),
        ],
      ),
    );
  }
}
