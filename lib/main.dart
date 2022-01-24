import 'package:flutter/material.dart';
import 'package:loja_completa/models/auth.dart';
import 'package:loja_completa/models/cart.dart';
import 'package:loja_completa/models/categoria_lista.dart';
import 'package:loja_completa/models/order_list.dart';
import 'package:loja_completa/models/product_list.dart';
import 'package:loja_completa/pages/cart_page.dart';
import 'package:loja_completa/pages/categoria_form_page.dart';
import 'package:loja_completa/pages/categorias_page.dart';
import 'package:loja_completa/pages/login_page.dart';
import 'package:loja_completa/pages/orders_pages.dart';
import 'package:loja_completa/pages/product_detalhe_page.dart';
import 'package:loja_completa/pages/product_form_page.dart';
import 'package:loja_completa/pages/product_page.dart';
import 'package:loja_completa/pages/productoverviewpage.dart';
import 'package:loja_completa/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', [], ''),
          update: (ctx, auth, previous) {
            return ProductList(
                auth.token ?? '', previous?.itens ?? [], auth.userId ?? '');
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList('', []),
          update: (ctx, auth, previous) {
            return OrderList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, CategoriaLista>(
          create: (_) => CategoriaLista('', []),
          update: (ctx, auth, previous) {
            return CategoriaLista(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loja Completa',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
            accentColor: Colors.amberAccent, // Your accent color
          ),
          fontFamily: 'Lato',
        ),
        home: Productoverviewpage(),
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.PRODTUC_DETAIL: (ctx) => ProductDetalhePage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDER: (ctx) => OrdersPages(),
          AppRoutes.PRODUCT_PAGE: (ctx) => ProductPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
          AppRoutes.CAT_FORM: (ctx) => CategoriaFormPage(),
          AppRoutes.LOGIN: (ctx) => LoginPage(),
          AppRoutes.CATEGORIAS: (ctx) => CategoriasPage(),
        },
      ),
    );
  }
}
