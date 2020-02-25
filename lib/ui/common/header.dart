import 'package:flutter/material.dart';
import 'package:pictile/themes/text_styles.dart';


class Header extends StatelessWidget {
  final String text;

  Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: blackTextStyle,
      ),
    );
  }
}
