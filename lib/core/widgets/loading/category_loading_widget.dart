import 'package:flutter/material.dart';

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "assets/images/single.gif",
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            ),
            Container(
              child: Image.asset(
                "assets/images/single.gif",
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
            Container(
              child: Image.asset(
                "assets/images/single.gif",
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
            Container(
              child: Image.asset(
                "assets/images/single.gif",
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            ),
          ],
        ),
      ),
    );
  }
}
