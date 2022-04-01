import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/drawer/model/Pages.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/ShowImageFullSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:url_launcher/url_launcher.dart';

class SinglePageView extends StatefulWidget {
  final HomeViewModel? home_data;
  final CategoryViewModel? category_data;
  final ThemeController themeDataController;
  final Pages pages;
  const SinglePageView(
      {Key? key,
      this.home_data,
      this.category_data,
      required this.pages,
      required this.themeDataController})
      : super(key: key);

  @override
  State<SinglePageView> createState() => _SinglePageViewState();
}

class _SinglePageViewState extends State<SinglePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: widget.themeDataController.isDark
                ? Theme.of(context).hintColor
                : Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeDataController.isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.sunny,
            ),
            onPressed: () {
              widget.themeDataController.changeTheme();
            },
          ),
        ],
        centerTitle: true,
        title: SizedBox(
          height: 30,
          child: Image.network(
            widget.home_data?.settings[0].logoUrl ?? TRANSPARENT_IMAGE_URL,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                widget.themeDataController.isDark
                    ? Color.fromARGB(255, 66, 34, 5)
                    : Color.fromARGB(255, 224, 116, 15),
                widget.themeDataController.isDark
                    ? Color.fromARGB(255, 105, 11, 69)
                    : Color.fromARGB(255, 253, 30, 168),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 10, top: 20),
                    child: MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        widget.pages.title ?? "",
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        widget.pages.content ?? "",
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
                        print(url);
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
