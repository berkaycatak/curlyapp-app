import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:html_unescape/html_unescape.dart';

class HomeMansetWidget extends StatelessWidget {
  final bool fullSize;
  final imageUrl;
  final title;
  final darkMode;
  const HomeMansetWidget(
      {Key? key,
      required this.fullSize,
      this.imageUrl,
      this.title,
      this.darkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    String _title = unescape.convert(title);

    double width = fullSize ? MediaQuery.of(context).size.width - 15 : 126;
    double height = fullSize ? 250 : 200;
    double height_s = fullSize ? 4.4 : 3;
    int line = fullSize ? 2 : 3;
    double fontSize = fullSize ? 16 : 14;
    double bottomPadding = fullSize ? 5 : 15;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                )),
          ),
          darkMode
              ? Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(90, 7, 0, 0),
                        Color.fromARGB(199, 0, 0, 0)
                      ],
                      stops: [0.0, 0.7],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: width,
                  height: height,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromARGB(0, 255, 255, 255),
                          Color.fromARGB(199, 0, 0, 0)
                        ],
                        stops: [0.0, 0.7],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: width,
                    height: height,
                  ),
                ),
          Container(
            width: width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: bottomPadding,
                    right: 20,
                    bottom: bottomPadding,
                    left: 20,
                  ),
                  child: Container(
                    height: height / height_s,
                    child: Text(
                      _title,
                      maxLines: line,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          color: darkMode
                              ? Color.fromARGB(255, 214, 213, 213)
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
