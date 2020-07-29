import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: GoogleFonts.ptSerif().fontFamily,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
        ),
        routes: {
          ProductDetailScreen.route: (context) => ProductDetailScreen(),
          CartScreen.route: (context) => CartScreen(),
        },
        home: ProductOverviewScreen(),
      ),
    );
  }
}
