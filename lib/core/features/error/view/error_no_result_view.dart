import 'package:flutter/material.dart';

class ErrorNoResultView extends StatelessWidget {
  final Widget widget;

  const ErrorNoResultView({Key? key, required this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/14_No_Search_Results.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.10,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: widget,
          )
        ],
      ),
    );
  }
}
