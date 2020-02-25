import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Color splashColor;
  final Function() onTap;
  final Color backgroundColor;
  final double paddingSize;

  CircleButton({
    @required this.child,
    @required this.onTap,
    this.splashColor = Colors.white,
    this.backgroundColor,
    this.paddingSize = 4,
  })  : assert(child != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      splashColor: splashColor,
      color: backgroundColor,
      shape: CircleBorder(),
      padding: EdgeInsets.all(0),
      minWidth: 0,
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: child,
      ),
    );
  }
}
