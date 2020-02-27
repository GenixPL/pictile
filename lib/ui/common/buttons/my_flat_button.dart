import 'package:flutter/material.dart';
import 'package:pictile/themes/text_styles.dart';

class MyFlatButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  MyFlatButton({
    @required this.text,
    @required this.onTap,
  })  : assert(text != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 32,
        child: FlatButton(
          onPressed: onTap,
          child: Text(
            text,
            style: smallBlackTextStyle,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
