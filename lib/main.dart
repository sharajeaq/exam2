import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_create_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Productos',
      theme: ThemeData(
        primarySwatch: Colors.teal, // MaterialColor válido
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListPage(),
        '/detail': (context) => ProductDetailPage(),
        '/create': (context) => ProductCreatePage(),
      },
    );
  }
}
