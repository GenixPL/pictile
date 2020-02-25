import 'package:flutter/material.dart';
import 'package:pictile/ui/common/app_text_style.dart';

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
            style: blackSmallTextStyle,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
