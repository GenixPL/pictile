import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/themes/main_theme.dart';
import 'package:provider/provider.dart';

import 'navigation/router.dart';

void main() async {
  runApp(MyApp());

  await db.init();
}

final router = Router();
final db = Db();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return ChangeNotifierProvider<DbHelper>(
      create: (_) => DbHelper(),
      child: MaterialApp(
        theme: mainTheme,
        initialRoute: homeRoute,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
