import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/single-post/view/ShowImageFullSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:html2md/html2md.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePostTemplate3 extends StatelessWidget {
  final Home? home_singleData;
  final Category? category_singleData;
  final ThemeController themeDataController;

  const SinglePostTemplate3(
      {Key? key,
      this.home_singleData,
      this.category_singleData,
      required this.themeDataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = home_singleData?.date ?? category_singleData?.date ?? "";
    String author_name =
        home_singleData?.authorName ?? category_singleData?.authorName ?? "";
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: themeDataController.isDark
                ? Theme.of(context).hintColor
                : Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
            ),
            onPressed: () {
              try {
                String shareText =
                    '"${home_singleData?.title ?? category_singleData?.title ?? ""}" ${home_singleData?.url ?? category_singleData?.url ?? ""}';
                Share.share(shareText);
              } catch (e) {}
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
                alignment: Alignment.topCenter,
                height: 300,
                width: double.infinity,
                child: Image.network(home_singleData?.thumbnailFull ??
                    category_singleData?.thumbnailFull ??
                    TRANSPARENT_IMAGE_URL),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                padding: EdgeInsets.all(10),
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    MarkdownBody(
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
                    SizedBox(height: 7.0),
                    Text(
                      author_name + " - " + date,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Color.fromARGB(255, 131, 131, 131),
                      ),
                    ),
                    SizedBox(height: 10.0),
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    */

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
                      onTapLink: (text, href, title) {
                        try {
                          launch(href ?? "");
                        } catch (e) {
                          print(e);
                        }
                      },
                      imageBuilder: (uri, title, alt) {
                        String url = "http://" + uri.host + uri.path;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            children: [
                              ClipRRect(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SliderShowFullmages(
                                          url: url,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.fitHeight,
                                    width: MediaQuery.of(context).size.width,
                                    errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) =>
                                        const SizedBox(),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(title ?? ""),
                              )
                            ],
                          ),
                        );
                      },
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
                    ),
                    */
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
