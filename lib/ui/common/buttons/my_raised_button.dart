import 'package:flutter/material.dart';
import 'package:pictile/themes/text_styles.dart';


class MyRaisedButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color backgroundColor;
  final TextStyle textStyle;

  MyRaisedButton({
    @required this.text,
    @required this.onTap,
    this.backgroundColor = Colors.black,
    this.textStyle,
  })  : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 32,
        child:
        RaisedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: (textStyle == null) ? smallWhiteTextStyle : textStyle,
          ),
          padding: EdgeInsets.all(0),
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          splashColor: Colors.white,
        ),
      ),
    );
  }
}
