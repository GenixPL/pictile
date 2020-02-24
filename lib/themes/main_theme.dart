import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.black,
  ),
  accentColor: Colors.black,
  primaryColor: Colors.black,

  // cursor color
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: Colors.black,
  ),
  cursorColor: Colors.black,
  textSelectionColor: Colors.black54,
);
