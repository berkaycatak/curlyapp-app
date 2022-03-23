import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllWidget extends StatelessWidget {
  final MaterialPageRoute route;
  final String title;
  const SeeAllWidget({
    Key? key,
    required this.route,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              route,
            ),
            child: Row(
              children: const [
                Text(
                  "Tümünü Gör",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
