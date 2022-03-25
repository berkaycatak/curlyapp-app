import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';

class LastArticleStoryWidget extends StatelessWidget {
  final image, title, date, darkMode;
  const LastArticleStoryWidget(
      {Key? key, this.image, this.title, this.date, this.darkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    String _title = unescape.convert(title);
    return Stack(
      children: <Widget>[
        Container(
          height: 350,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: 190,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(image, fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: darkMode
                  ? LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(90, 7, 0, 0),
                        Color.fromARGB(199, 0, 0, 0)
                      ],
                      stops: [0.0, 1.2],
                    )
                  : LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      stops: [0.0, 1],
                    ),
              borderRadius: BorderRadius.circular(12)),
          width: 190,
        ),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: 190,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0, left: 8, right: 8),
                child: Text(
                  _title,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkMode
                          ? const Color.fromARGB(255, 214, 213, 213)
                          : Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              )),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
