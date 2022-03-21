import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SinglePostView extends StatelessWidget {
  final Home singleData;
  const SinglePostView({Key? key, required this.singleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: Image.network(
            singleData.logoUrl ??
                "https://kisavoz.com/wp-content/uploads/2018/06/Ba%C5%9Fl%C4%B1ks%C4%B1z-1-3-1.jpg",
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 54, 10, 16),
                  Color.fromARGB(255, 71, 27, 33),
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(singleData.thumbnailFull ?? ""),
            Text(singleData.title ?? ""),
            SelectableHtml(
              data: singleData.content ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
