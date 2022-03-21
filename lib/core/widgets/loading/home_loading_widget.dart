import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Image.asset(
              "assets/images/single.gif",
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  child: Image.asset("assets/images/story.gif"),
                  padding: EdgeInsets.only(),
                ),
                Container(
                  width: 130,
                  child: Image.asset("assets/images/story.gif"),
                  padding: EdgeInsets.only(),
                ),
                Container(
                  width: 130,
                  child: Image.asset("assets/images/story.gif"),
                  padding: EdgeInsets.only(),
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
