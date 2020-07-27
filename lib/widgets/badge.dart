import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Badge extends StatelessWidget {
  Badge({@required this.child, this.value, this.color});
  final Widget child;
  final int value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        value > 0
            ? Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        color == null ? Theme.of(context).accentColor : color,
                  ),
                  constraints: BoxConstraints(minHeight: 16, minWidth: 16),
                  child: Center(
                    child: Text(
                      value.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              )
            : Text(''),
      ],
    );
  }
}
