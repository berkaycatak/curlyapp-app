import 'package:curlyapp/core/constants/constants.dart';
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
            NO_SEARCH_RESULTS_PATH,
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
