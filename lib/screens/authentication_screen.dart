import 'package:flutter/material.dart';
import '../widgets/shop_logo.dart';
import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  static const String route = 'shop_app/screens/authentication_screen.dart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 0.5),
                    Color.fromRGBO(255, 188, 117, 0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 1]),
            ),
          ),
          Column(
            children: [ShopLogo(), AuthenticationForm()],
          )
        ],
      )),
    );
  }
}
