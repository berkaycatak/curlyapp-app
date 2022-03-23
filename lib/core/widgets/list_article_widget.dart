import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape_small.dart';

class ListArticleWidget extends StatelessWidget {
  final title, image, time, editor;
  const ListArticleWidget(
      {Key? key, this.title, this.image, this.time, this.editor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    String _title = unescape.convert(title);

    String _editor = editor != "" ? editor + " - " : "";
    print(_editor.length);
    if (_editor.length > 15) _editor = _editor.substring(0, 15) + "... -";
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Text(
                  _title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      _editor,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      time,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
