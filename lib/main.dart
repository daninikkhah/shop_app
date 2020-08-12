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
import './providers/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
//        ChangeNotifierProxyProvider
        ChangeNotifierProxyProvider<Authentication, ProductsProvider>(
          create: (context) => ProductsProvider(),
          update: (context, auth, previousProduct) =>
              previousProduct..getAuthToken(auth.token),
        ), //TODO understand what the hell is going on
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Authentication, Orders>(
          create: (context) => Orders(),
          update: (context, auth, previousOrder) =>
              Orders()..getAuthToken(auth.token),
        ),
      ],
      child: Consumer<Authentication>(
          builder: (context, auth, child) => MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: GoogleFonts.ptSerif().fontFamily,
                  textTheme: TextTheme(
                    headline6: TextStyle(color: Colors.white),
                  ),
                ),
                routes: {
                  AuthenticationScreen.route: (context) =>
                      AuthenticationScreen(),
                  ProductOverviewScreen.route: (context) =>
                      ProductOverviewScreen(),
                  ProductDetailScreen.route: (context) => ProductDetailScreen(),
                  CartScreen.route: (context) => CartScreen(),
                  OrdersScreen.route: (context) => OrdersScreen(),
                  UserProductsScreen.route: (context) => UserProductsScreen(),
                  EditProductScreen.route: (context) => EditProductScreen(),
                },
                home: auth.isAuthenticated
                    ? ProductOverviewScreen()
                    : AuthenticationScreen(),
                //onUnknownRoute: (_)=>  ProductOverviewScreen(),
              )),
    );
  }
}
