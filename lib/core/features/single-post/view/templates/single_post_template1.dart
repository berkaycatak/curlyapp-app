import 'package:admob_flutter/admob_flutter.dart';
import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/single-post/view/ShowImageFullSlider.dart';
import 'package:curlyapp/core/services/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:url_launcher/url_launcher.dart';

class SinglePostTemplate1 extends StatefulWidget {
  final Home? home_singleData;
  final Category? category_singleData;
  final ThemeController themeDataController;

  const SinglePostTemplate1(
      {Key? key,
      this.home_singleData,
      this.category_singleData,
      required this.themeDataController})
      : super(key: key);

  @override
  State<SinglePostTemplate1> createState() => _SinglePostTemplate1State();
}

class _SinglePostTemplate1State extends State<SinglePostTemplate1> {
  final ams = AdMobService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Admob.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> funSad() async {}
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: widget.themeDataController.isDark
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
                    '"${widget.home_singleData?.title ?? widget.category_singleData?.title ?? ""}" ${widget.home_singleData?.url ?? widget.category_singleData?.url ?? ""}';
                Share.share(shareText);
              } catch (e) {}
            },
          ),
        ],
        centerTitle: true,
        title: SizedBox(
          height: 30,
          child: Image.network(
            widget.home_singleData?.logoUrl ??
                widget.category_singleData?.logourl ??
                TRANSPARENT_IMAGE_URL,
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
      body: RefreshIndicator(
        onRefresh: (() => funSad()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: MarkdownBody(
                  selectable: true,
                  data: html2md.convert(
                    widget.home_singleData?.title ??
                        widget.category_singleData?.title ??
                        "",
                  ),
                  styleSheet: MarkdownStyleSheet(
                    p: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.home_singleData?.authorName ??
                                widget.category_singleData?.authorName ??
                                "",
                            style: GoogleFonts.muli(
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.home_singleData?.date ??
                                widget.category_singleData?.date ??
                                "",
                            style: GoogleFonts.muli(
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SliderShowFullmages(
                                    url:
                                        widget.home_singleData?.thumbnailFull ??
                                            widget.category_singleData
                                                ?.thumbnailFull ??
                                            "",
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              widget.home_singleData?.thumbnailFull ??
                                  widget.category_singleData?.thumbnailFull ??
                                  "",
                              fit: BoxFit.fitHeight,
                              width: MediaQuery.of(context).size.width,
                              errorBuilder: (BuildContext context, Object error,
                                      StackTrace? stackTrace) =>
                                  const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4, top: 10, bottom: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 30,
                        child: AdmobBanner(
                          adUnitId: ams.getBannerAdId(),
                          adSize: AdmobBannerSize.LARGE_BANNER,
                        ),
                      ),
                    ),
                    MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        widget.home_singleData?.content ??
                            widget.category_singleData?.icerik ??
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4, top: 10, bottom: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 30,
                        child: AdmobBanner(
                          adUnitId: ams.getBannerAdId(),
                          adSize: AdmobBannerSize.LARGE_BANNER,
                        ),
                      ),
                    ),
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
