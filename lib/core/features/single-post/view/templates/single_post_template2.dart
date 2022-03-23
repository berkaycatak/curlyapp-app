import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;

class SinglePostTemplate2 extends StatelessWidget {
  final Home? home_singleData;
  final Category? category_singleData;

  const SinglePostTemplate2(
      {Key? key, this.home_singleData, this.category_singleData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  child: Image.network(
                    home_singleData?.thumbnailFull ??
                        category_singleData?.thumbnailFull ??
                        "",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, -1),
                        blurRadius: 20),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: Container(
                        child: MarkdownBody(
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  home_singleData?.authorName ??
                                      category_singleData?.authorName ??
                                      "",
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 131, 131, 131),
                                  ),
                                ),
                                Text(
                                  home_singleData?.date ??
                                      category_singleData?.date ??
                                      "",
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 131, 131, 131),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 20),
                          /*
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: AdmobBanner(
                          adUnitId: untilId,
                          adSize: AdmobBannerSize.LARGE_BANNER,
                        ),
                      ),
                      */
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: MarkdownBody(
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
                          ),
                          Divider(),
                          /*
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: AdmobBanner(
                          adUnitId: untilId,
                          adSize: AdmobBannerSize.LARGE_BANNER,
                        ),
                      ),
                      */
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
