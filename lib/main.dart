import 'package:flutter/material.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: GoogleFonts.ptSerif().fontFamily,
      ),
      home: ProductOverviewScreen(),
    );
  }
}
