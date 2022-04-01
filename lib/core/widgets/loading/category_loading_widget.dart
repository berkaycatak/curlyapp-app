import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CategoryLoadingWidget extends StatelessWidget {
  final ThemeController themeDataController;

  const CategoryLoadingWidget({Key? key, required this.themeDataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                themeDataController.isDark ? MANSET_DARK_PATH : MANSET_PATH,
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            ),
            Container(
              child: Image.asset(
                themeDataController.isDark ? SINGLE_DARK_PATH : SINGLE_PATH,
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
            Container(
              child: Image.asset(
                themeDataController.isDark ? SINGLE_DARK_PATH : SINGLE_PATH,
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
            Container(
              child: Image.asset(
                themeDataController.isDark ? SINGLE_DARK_PATH : SINGLE_PATH,
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
          ],
        ),
      ),
    );
  }
}
