import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        theme: themeController.themeData,
        debugShowCheckedModeBanner: false,
        title: "Material",
        home: SplashView(
          themeDataController: themeController,
        ),
      );
    });
  }
}
