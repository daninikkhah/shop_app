import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/authentication_screen.dart';
import './screens/loading_screen.dart';
import './providers/authentication.dart';

void main() {
  //SharedPreferences.setMockInitialValues({});

  runApp(MyApp());
}

//TODO Important fix fug : wont reach Authentication screen when logout from pages other then first loaded pge
class MyApp extends StatelessWidget {
//  Widget buildHome(BuildContext context, Authentication auth) {
//    print('build home');
//    print(auth.isAuthenticated);
//    if (auth.isAuthenticated) {
//      print('ProductOverviewScreen');
//      return ProductOverviewScreen();
//    } else {
//      print('FutureBuilder');
//      return FutureBuilder(
//          future: auth.autoLogin(),
//          builder: (context, snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              print('LoadingScreen');
//              return LoadingScreen();
//            } else {
//              //wont reach here pressing logout
//              print('else');
//              if (snapshot.connectionState == ConnectionState.none)
//                print('future = null');
//              if (snapshot.connectionState == ConnectionState.done)
//                print('done');
//              if (snapshot.connectionState == ConnectionState.active)
//                print('active');
//              print('AuthenticationScreen');
//              return AuthenticationScreen();
//            }
//          });
//    }
//    //AuthenticationScreen(),
//    //onUnknownRoute: (_)=>  ProductOverviewScreen(),
//  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
//        ChangeNotifierProxyProvider
        ChangeNotifierProxyProvider<Authentication, ProductsProvider>(
          create: (context) => ProductsProvider(),
          update: (context, auth, previousProduct) =>
              previousProduct..getAuthToken(auth.token, auth.id),
        ), //TODO understand what the hell is going on
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Authentication, Orders>(
          create: (context) => Orders(),
          update: (context, auth, previousOrder) =>
              Orders()..getAuthToken(token: auth.token, userId: auth.id),
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
            AuthenticationScreen.route: (context) => AuthenticationScreen(),
            ProductOverviewScreen.route: (context) => ProductOverviewScreen(),
            ProductDetailScreen.route: (context) => ProductDetailScreen(),
            CartScreen.route: (context) => CartScreen(),
            OrdersScreen.route: (context) => OrdersScreen(),
            UserProductsScreen.route: (context) => UserProductsScreen(),
            EditProductScreen.route: (context) => EditProductScreen(),
          },
          home: auth.isAuthenticated
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : AuthenticationScreen(),
                ),
          // onUnknownRoute: (_)=>  Navigator.of(context).pushNamed(ProductOverviewScreen.route)
        ),
      ),
    );
  }
}
