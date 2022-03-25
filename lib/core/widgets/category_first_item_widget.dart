import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:html2md/html2md.dart' as html2md;

class CategoryFirstItemWidget extends StatelessWidget {
  final image, title, categoryName, date, content;
  const CategoryFirstItemWidget(
      {Key? key,
      this.image,
      this.title,
      this.categoryName,
      this.date,
      this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    String _title = unescape.convert(title);

    String _content = content;
    if (_content.length > 200) _content = _content.substring(0, 200);
    return Container(
      height: 350,
      child: Stack(
        children: [
          Image.network(
            image,
            height: 350,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(199, 0, 0, 0)
                ],
                stops: [0, 0.6],
              ),
            ),
            height: 350,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 250, 18, 2),
                      ),
                      child: Text(
                        categoryName,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Text(
                  _title,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 5),
                child: MarkdownBody(
                  selectable: true,
                  data: html2md.convert(_content),
                  styleSheet: MarkdownStyleSheet(
                    p: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Color.fromARGB(255, 190, 190, 190),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
