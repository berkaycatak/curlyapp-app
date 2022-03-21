import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesButton extends StatelessWidget {
  final categoryName;
  final Color color;
  const CategoriesButton({Key? key, this.categoryName, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(left: 7, top: 10),
      padding: EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
      child: Text(
        "#" + categoryName,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
