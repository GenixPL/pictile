import 'package:flutter/material.dart';
import 'package:pictile/ui/common/app_text_style.dart';

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
  })  : assert(text != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 32,
        child: RaisedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: (textStyle == null) ? whiteTextStyle : textStyle,
          ),
          padding: EdgeInsets.all(0),
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          splashColor: Colors.white,
        ),
      ),
    );
  }
}
