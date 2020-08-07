import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-25.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[700],
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(2, 2)),
          ],
        ),
        child: Text(
          'Outland Shop',
          textAlign: TextAlign.center,
          style: GoogleFonts.rockSalt().copyWith(
              fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
    );
  }
}
