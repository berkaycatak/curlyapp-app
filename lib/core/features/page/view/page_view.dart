import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/drawer/model/Pages.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;

class SinglePageView extends StatelessWidget {
  final HomeViewModel? home_data;
  final CategoryViewModel? category_data;
  final Pages pages;
  const SinglePageView(
      {Key? key, this.home_data, this.category_data, required this.pages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 30,
          child: Image.network(
            home_data?.settings[0].logoUrl ?? TRANSPARENT_IMAGE_URL,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        pages.title ?? "",
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
                    padding: const EdgeInsets.all(10.0),
                    child: MarkdownBody(
                      selectable: true,
                      data: html2md.convert(
                        pages.content ?? "",
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
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
