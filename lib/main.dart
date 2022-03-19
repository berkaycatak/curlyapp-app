import 'package:curlyapp/core/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

import 'core/features/home/view/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Material",
      home: SplashView(),
    );
  }
}
