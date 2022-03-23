import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;

class SinglePostTemplate4 extends StatelessWidget {
  final Home? home_singleData;
  final Category? category_singleData;
  final ThemeController themeDataController;

  const SinglePostTemplate4(
      {Key? key,
      this.home_singleData,
      this.category_singleData,
      required this.themeDataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = home_singleData?.date ?? category_singleData?.date ?? "";
    String author_name =
        home_singleData?.authorName ?? category_singleData?.title ?? "";

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: themeDataController.isDark
                ? Theme.of(context).hintColor
                : Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              themeDataController.isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.sunny,
            ),
            onPressed: () {
              themeDataController.changeTheme();
            },
          ),
        ],
        centerTitle: true,
        title: SizedBox(
          height: 30,
          child: Image.network(
            home_singleData?.logoUrl ??
                category_singleData?.logourl ??
                TRANSPARENT_IMAGE_URL,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                themeDataController.isDark
                    ? Color.fromARGB(255, 66, 34, 5)
                    : Color.fromARGB(255, 224, 116, 15),
                themeDataController.isDark
                    ? Color.fromARGB(255, 105, 11, 69)
                    : Color.fromARGB(255, 253, 30, 168),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  home_singleData?.thumbnailFull ??
                      category_singleData?.thumbnailFull ??
                      TRANSPARENT_IMAGE_URL,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MarkdownBody(
                      shrinkWrap: true,
                      selectable: true,
                      data: html2md.convert(
                        home_singleData?.title ??
                            category_singleData?.title ??
                            "",
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(author_name + " - " + date),
                    SizedBox(height: 10.0),
                    Divider(),
                    SizedBox(
                      height: 10.0,
                    ),
                    /*
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: AdmobBanner(
                        adUnitId: untilId,
                        adSize: AdmobBannerSize.LARGE_BANNER,
                      ),
                    ),
                    */
                    SizedBox(
                      height: 10.0,
                    ),
                    MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        home_singleData?.content ??
                            category_singleData?.icerik ??
                            "",
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    /*
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: AdmobBanner(
                        adUnitId: untilId,
                        adSize: AdmobBannerSize.LARGE_BANNER,
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
