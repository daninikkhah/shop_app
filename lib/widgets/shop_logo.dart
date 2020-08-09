import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-25.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[700],
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(2, 2)),
          ],
        ),
        child: FittedBox(
          child: Text(
            'Outland Shop',
            textAlign: TextAlign.center,
            style: GoogleFonts.rockSalt().copyWith(
                fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
