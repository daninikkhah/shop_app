import 'package:flutter/material.dart';

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({this.builder, this.settings})
      : super(builder: builder, settings: settings);
  final WidgetBuilder builder;
  final RouteSettings settings;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );
}
