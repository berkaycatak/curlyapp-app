import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMansetWidget extends StatelessWidget {
  final bool fullSize;
  final imageUrl;
  final title;
  const HomeMansetWidget(
      {Key? key, required this.fullSize, this.imageUrl, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = fullSize ? MediaQuery.of(context).size.width - 15 : 126;
    double height = fullSize ? 250 : 200;
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
          Padding(
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
                    stops: [
                      0.0,
                      0.7
                    ]),
                borderRadius: BorderRadius.circular(20),
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
                    height: height / 4.4,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          color: Color.fromARGB(255, 231, 231, 231),
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
