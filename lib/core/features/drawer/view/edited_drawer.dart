import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/features/category/view/category_view.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/page/view/page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final ThemeController themeController;

  const MyHomePage(
      {Key? key, required this.homeViewModel, required this.themeController})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.homeViewModel.settings[0].appName ?? "",
                    style: textTheme.headline6,
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple.withOpacity(0.14),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.deepPurple,
                      textDirection: TextDirection.rtl,
                    ),
                    title: Text(
                      "Anasayfa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 30),
                  child: Text(
                    "Kategoriler",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: widget.homeViewModel.categories.length * 55,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.homeViewModel.categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.arrow_left,
                          textDirection: TextDirection.rtl,
                        ),
                        title: Text(widget
                                .homeViewModel.categories[index].categoryName ??
                            ""),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryView(
                                categoryId: int.parse(widget
                                    .homeViewModel.categories[index].categoryId
                                    .toString()),
                                homeViewModel: widget.homeViewModel,
                                themeController: widget.themeController,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    "Sayfalar",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: widget.homeViewModel.pages.length * 55,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.homeViewModel.pages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.arrow_left,
                          textDirection: TextDirection.rtl,
                        ),
                        title:
                            Text(widget.homeViewModel.pages[index].title ?? ""),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePageView(
                              themeDataController: widget.themeController,
                              home_data: widget.homeViewModel,
                              pages: widget.homeViewModel.pages[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10, right: 10),
                  child: Text(
                    "Bizi Sosyal Medya'da Takip Et!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.homeViewModel.social[0].instagram != "none"
                          ? SocialIcon(
                              color: Color.fromRGBO(201, 45, 142, 1),
                              icon: const Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              ),
                              url: widget.homeViewModel.social[0].instagram
                                  as String,
                            )
                          : const SizedBox(),
                      widget.homeViewModel.social[0].twitter != "none"
                          ? SocialIcon(
                              color: Color.fromRGBO(0, 172, 238, 1),
                              icon: const Icon(FontAwesomeIcons.twitter,
                                  color: Colors.white),
                              url: widget.homeViewModel.social[0].twitter
                                  as String,
                            )
                          : const SizedBox(),
                      widget.homeViewModel.social[0].pinterest != "none"
                          ? SocialIcon(
                              color: Color.fromRGBO(189, 8, 28, 1),
                              icon: const Icon(FontAwesomeIcons.pinterest,
                                  color: Colors.white),
                              url: widget.homeViewModel.social[0].pinterest
                                  as String,
                            )
                          : const SizedBox(),
                      widget.homeViewModel.social[0].facebook != "none"
                          ? SocialIcon(
                              color: Color.fromRGBO(59, 89, 152, 1),
                              icon: const Icon(
                                Icons.facebook,
                                color: Colors.white,
                              ),
                              url: widget.homeViewModel.social[0].instagram
                                  as String,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String url;
  const SocialIcon(
      {Key? key, required this.color, required this.icon, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 40,
      width: 40,
      child: IconButton(
        icon: icon,
        onPressed: () => _launchURL(url),
      ),
    );
  }
}

void _launchURL(String _url) async {
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
