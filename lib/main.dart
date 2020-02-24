import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/themes/main_theme.dart';

import 'navigation/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final router = Router();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      initialRoute: homeRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
