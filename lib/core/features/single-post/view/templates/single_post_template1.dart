import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:html2md/html2md.dart' as html2md;

class SinglePostTemplate1 extends StatelessWidget {
  final Home? home_singleData;
  final Category? category_singleData;

  const SinglePostTemplate1(
      {Key? key, this.home_singleData, this.category_singleData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> funSad() async {}
    ;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 30,
          child: Image.network(
            home_singleData?.logoUrl ??
                category_singleData?.logourl ??
                "https://kisavoz.com/wp-content/uploads/2018/06/Ba%C5%9Fl%C4%B1ks%C4%B1z-1-3-1.jpg",
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromARGB(255, 224, 116, 15),
                  Color.fromARGB(255, 253, 30, 168),
                ]),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
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
                    home_singleData?.title ?? category_singleData?.title ?? "",
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
                            home_singleData?.authorName ??
                                category_singleData?.authorName ??
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
                            home_singleData?.date ??
                                category_singleData?.date ??
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
                          child: Center(
                            child: FadeInImage.memoryNetwork(
                              image: home_singleData?.thumbnailFull ??
                                  category_singleData?.thumbnailFull ??
                                  "",
                              fadeInDuration: Duration(milliseconds: 300),
                              placeholder: kTransparentImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    /*Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: AdmobBanner(
                        adUnitId: untilId,
                        adSize: AdmobBannerSize.LARGE_BANNER,
                      ),
                    ),*/
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
                    Divider(),
                    /*SosyalMedyadaPaylas(
                      url: "widget.",
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
        /*Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              child: AdmobBanner(
                adUnitId: untilId,
                adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
              ),
            ),*/
      ),
    );
  }
}
