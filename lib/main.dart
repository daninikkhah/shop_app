import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/authentication_screen.dart';

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
          AuthenticationScreen.route: (context) => AuthenticationScreen(),
          ProductOverviewScreen.route: (context) => ProductOverviewScreen(),
          ProductDetailScreen.route: (context) => ProductDetailScreen(),
          CartScreen.route: (context) => CartScreen(),
          OrdersScreen.route: (context) => OrdersScreen(),
          UserProductsScreen.route: (context) => UserProductsScreen(),
          EditProductScreen.route: (context) => EditProductScreen(),
        },
        home: AuthenticationScreen(),
        //onUnknownRoute: (_)=>  ProductOverviewScreen(),
      ),
    );
  }
}
