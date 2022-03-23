import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomStoryArticleWidget extends StatelessWidget {
  final image, title, date, author;
  const BottomStoryArticleWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.date,
      required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.grey.withOpacity(0.0), Colors.black],
                stops: [0.0, 0.9],
              ),
              borderRadius: BorderRadius.circular(20),
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
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
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
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
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
