import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape_small.dart';

class BottomStoryArticleWidget extends StatelessWidget {
  final image, title, date, author, darkMode;
  const BottomStoryArticleWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.date,
      required this.author,
      this.darkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    String _title = unescape.convert(title);

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            borderRadius: BorderRadius.circular(15),
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
                      stops: [0.0, 0.7],
                    )
                  : LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      stops: [0.0, 0.9],
                    ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _title,
                    style: GoogleFonts.poppins(
                      color: darkMode
                          ? const Color.fromARGB(255, 214, 213, 213)
                          : Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        author,
                        style: GoogleFonts.poppins(
                          color: darkMode
                              ? const Color.fromARGB(255, 214, 213, 213)
                              : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: darkMode
                              ? const Color.fromARGB(255, 214, 213, 213)
                              : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
