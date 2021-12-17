import 'package:flutter/material.dart';
import 'package:loja_completa/models/product_list.dart';
import 'package:loja_completa/pages/product_detalhe_page.dart';
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
          create: (_) => ProductList(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loja Completa',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        home: Productoverviewpage(),
        routes: {
          AppRoutes.PRODTUC_DETAIL: (ctx) => ProductDetalhePage(),
        },
      ),
    );
  }
}
