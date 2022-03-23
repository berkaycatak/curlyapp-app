import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/single-post/view/templates/single_post_template1.dart';
import 'package:curlyapp/core/features/single-post/view/templates/single_post_template2.dart';
import 'package:curlyapp/core/features/single-post/view/templates/single_post_template3.dart';
import 'package:curlyapp/core/features/single-post/view/templates/single_post_template4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SinglePostView extends StatelessWidget {
  final Home? home_singleData;
  final Category? category_singleData;
  final ThemeController themeController;

  const SinglePostView(
      {Key? key,
      this.home_singleData,
      this.category_singleData,
      required this.themeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (home_singleData?.postStyle == "1" ||
        home_singleData?.postStyle == "1") {
      return SinglePostTemplate1(
          home_singleData: home_singleData,
          category_singleData: category_singleData, themeDataController: themeController,);
    } else if (home_singleData?.postStyle == "2" ||
        home_singleData?.postStyle == "2") {
      return SinglePostTemplate2(
          home_singleData: home_singleData,
          category_singleData: category_singleData, themeDataController: themeController,);
    } else if (home_singleData?.postStyle == "3" ||
        home_singleData?.postStyle == "3") {
      return SinglePostTemplate3(
          home_singleData: home_singleData,
          category_singleData: category_singleData, themeDataController: themeController,);
    } else if (home_singleData?.postStyle == "4" ||
        home_singleData?.postStyle == "4") {
      return SinglePostTemplate4(
          home_singleData: home_singleData,
          category_singleData: category_singleData, themeDataController: themeController,);
    } else {
      return SinglePostTemplate1(
          home_singleData: home_singleData,
          category_singleData: category_singleData, themeDataController: themeController,);
    }
  }
}
