import 'package:flutter/material.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: GoogleFonts.ptSerif().fontFamily,
        ),
        routes: {
          ProductDetailScreen.route: (context) => ProductDetailScreen(),
        },
        home: ProductOverviewScreen(),
      ),
    );
  }
}
