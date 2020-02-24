import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/themes/main_theme.dart';

import 'navigation/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final router = Router();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      theme: mainTheme,
      initialRoute: manageAddRoute, //TODO
      onGenerateRoute: router.generateRoute,
    );
  }
}
