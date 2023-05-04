import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_screen.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_overview_page.dart';
import 'package:shop_app/pages/user_product_page.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import './pages/product_detail_page.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //We dont use .value here even though it works perfectly because
          //Inside ProductProvider() we are creating a new INstance
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'lato',
            primaryColor: Color.fromARGB(255, 3, 67, 120),
            canvasColor: Color.fromARGB(255, 3, 67, 120)),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductOverviewPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
          UserProductPage.routeName: (ctx) => UserProductPage(),
          EditProductPage.routeName: (ctx) => EditProductPage()
        },
      ),
    );
  }
}
