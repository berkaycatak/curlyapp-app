import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SliderShowFullmages extends StatefulWidget {
  final String url;

  const SliderShowFullmages({Key? key, required this.url}) : super(key: key);
  @override
  _SliderShowFullmagesState createState() => _SliderShowFullmagesState();
}

class _SliderShowFullmagesState extends State<SliderShowFullmages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //title: const Text('Transaction Detail'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: PhotoView(
            imageProvider: NetworkImage(
              widget.url,
            ),
            maxScale: 0.9,
            minScale: 0.3,
          ),
        ),
      ),
    );
  }
}
