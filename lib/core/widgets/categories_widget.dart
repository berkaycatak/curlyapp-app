import 'package:curlyapp/core/widgets/categories_button.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> renk = [
      Colors.blueAccent,
      Colors.purple,
      Colors.orange,
      Colors.greenAccent,
      Colors.teal,
      Colors.orange,
      Colors.blue,
      Colors.purple
    ];
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoriesButton(
            categoryName: "Teknoloji",
            color: renk[0],
          ),
          CategoriesButton(
            categoryName: "Oyun",
            color: renk[1],
          ),
          CategoriesButton(
            categoryName: "Gündem",
            color: renk[2],
          ),
          CategoriesButton(
            categoryName: "Nasıl Yapılır?",
            color: renk[3],
          ),
        ],
      ),
    );
  }
}
