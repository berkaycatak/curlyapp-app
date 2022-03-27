import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/view/category_view.dart';
import 'package:curlyapp/core/features/drawer/view/edited_drawer.dart';
import 'package:curlyapp/core/features/error/view/error_404_view.dart';
import 'package:curlyapp/core/features/error/view/error_connection_view.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:curlyapp/core/widgets/animated_list_item.dart';
import 'package:curlyapp/core/widgets/bottom_story_article_widget.dart';
import 'package:curlyapp/core/widgets/home_manset_widget.dart';
import 'package:curlyapp/core/widgets/last_article_story_widget.dart';
import 'package:curlyapp/core/widgets/list_article_widget.dart';
import 'package:curlyapp/core/widgets/loading/home_loading_widget.dart';
import 'package:curlyapp/core/widgets/see_all_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  final ThemeController themeDataController;
  HomeView(
      {Key? key, required this.viewModel, required this.themeDataController})
      : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          //backgroundColor: Color.fromARGB(255, 35, 37, 51),
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: widget.themeDataController.isDark
                    ? Theme.of(context).hintColor
                    : Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  widget.themeDataController.isDark
                      ? Icons.wb_sunny_outlined
                      : Icons.sunny,
                ),
                onPressed: () {
                  widget.themeDataController.changeTheme();
                },
              ),
            ],
            centerTitle: true,
            title: SizedBox(
              height: 30,
              child: Image.network(
                widget.viewModel.settings[0].logoUrl ?? TRANSPARENT_IMAGE_URL,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    widget.themeDataController.isDark
                        ? Color.fromARGB(255, 66, 34, 5)
                        : Color.fromARGB(255, 224, 116, 15),
                    widget.themeDataController.isDark
                        ? Color.fromARGB(255, 105, 11, 69)
                        : Color.fromARGB(255, 253, 30, 168),
                  ],
                ),
              ),
            ),
          ),
          drawer: MyHomePage(
            homeViewModel: widget.viewModel,
            themeController: widget.themeDataController,
          ),
          body: RefreshIndicator(
            onRefresh: () => widget.viewModel.getHomepage(1),
            child: (widget.viewModel.isServiceRequestLoading == STATUS_LOADING)
                ? LoadingWidget()
                : (widget.viewModel.isServiceRequestLoading == STATUS_ERROR)
                    ? Error404View()
                    : (widget.viewModel.isServiceRequestLoading ==
                            STATUS_NO_INTERNET)
                        ? ErrorConnectionView()
                        : SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // manset
                                  SizedBox(
                                    height: 260,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostView(
                                                home_singleData: widget
                                                    .viewModel
                                                    .mansetData[index],
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(
                                            index,
                                            key: ValueKey<int>(index),
                                            widget: HomeMansetWidget(
                                              fullSize: true,
                                              imageUrl: widget
                                                  .viewModel
                                                  .mansetData[index]
                                                  .thumbnailFull,
                                              title: widget.viewModel
                                                  .mansetData[index].title,
                                              darkMode: widget
                                                  .themeDataController.isDark,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    height: 210,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          widget.viewModel.mansetData.length -
                                              1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0) {
                                          index = 1;
                                        } else {
                                          index++;
                                        }
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostView(
                                                home_singleData: widget
                                                    .viewModel
                                                    .mansetData[index],
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(
                                            index,
                                            key: ValueKey<int>(index),
                                            widget: HomeMansetWidget(
                                              fullSize: false,
                                              imageUrl: widget
                                                  .viewModel
                                                  .mansetData[index]
                                                  .thumbnailFull,
                                              title: widget.viewModel
                                                  .mansetData[index].title,
                                              darkMode: widget
                                                  .themeDataController.isDark,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // manşet bitis
                                  // kategoriler
                                  // const CategoriesWidget(),
                                  // kategoriler bitiş

                                  // manşet alt
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.viewModel.mansetAltData[0]
                                                  .catName ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryView(
                                                homeViewModel: widget.viewModel,
                                                categoryId: widget
                                                        .viewModel
                                                        .mansetAltData[0]
                                                        .catId ??
                                                    1,
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
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
                                  ),
                                  SizedBox(
                                    height: widget.viewModel.hikayeData.length *
                                        125,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          widget.viewModel.mansetAltData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostView(
                                                home_singleData: widget
                                                    .viewModel
                                                    .mansetAltData[index],
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(index,
                                              key: ValueKey<int>(index),
                                              widget: ListArticleWidget(
                                                title: widget.viewModel
                                                    .mansetAltData[index].title,
                                                image: widget
                                                    .viewModel
                                                    .mansetAltData[index]
                                                    .thumbnailFull,
                                                time: widget.viewModel
                                                    .mansetAltData[index].date,
                                                editor: widget
                                                    .viewModel
                                                    .mansetAltData[index]
                                                    .authorName,
                                                darkMode: widget
                                                    .themeDataController.isDark,
                                              )),
                                        );
                                      },
                                    ),
                                  ),
                                  // manşet alt bitiş
                                  // hikaye

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.viewModel.hikayeData[0]
                                                  .catName ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryView(
                                                homeViewModel: widget.viewModel,
                                                categoryId: widget.viewModel
                                                        .hikayeData[0].catId ??
                                                    1,
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
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
                                  ),

                                  SizedBox(
                                    height: 350,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            widget.viewModel.hikayeData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SinglePostView(
                                                  home_singleData: widget
                                                      .viewModel
                                                      .hikayeData[index],
                                                  themeController: widget
                                                      .themeDataController,
                                                ),
                                              ),
                                            ),
                                            child: AnimatedListItem(
                                              index,
                                              key: ValueKey<int>(index),
                                              widget: LastArticleStoryWidget(
                                                title: widget.viewModel
                                                    .hikayeData[index].title,
                                                image: widget
                                                    .viewModel
                                                    .hikayeData[index]
                                                    .thumbnailFull,
                                                date: widget.viewModel
                                                    .hikayeData[index].date,
                                                darkMode: widget
                                                    .themeDataController.isDark,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // hikaye bitiş
                                  // hikaye alt

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.viewModel.hikayeAltData[0]
                                                  .catName ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryView(
                                                homeViewModel: widget.viewModel,
                                                categoryId: widget
                                                        .viewModel
                                                        .hikayeAltData[0]
                                                        .catId ??
                                                    1,
                                                themeController:
                                                    widget.themeDataController,
                                              ),
                                            ),
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
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                        top: 8,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 4 * 210,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .viewModel.hikayeAltData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SinglePostView(
                                                  home_singleData: widget
                                                      .viewModel
                                                      .hikayeAltData[index],
                                                  themeController: widget
                                                      .themeDataController,
                                                ),
                                              ),
                                            ),
                                            child: AnimatedListItem(
                                              index,
                                              key: ValueKey<int>(index),
                                              widget: BottomStoryArticleWidget(
                                                title: widget.viewModel
                                                    .hikayeAltData[index].title,
                                                image: widget
                                                    .viewModel
                                                    .hikayeAltData[index]
                                                    .thumbnailFull,
                                                date: widget.viewModel
                                                    .hikayeAltData[index].date,
                                                author: widget
                                                    .viewModel
                                                    .hikayeAltData[index]
                                                    .authorName,
                                                darkMode: widget
                                                    .themeDataController.isDark,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // hikaye alt bitiş
                                ],
                              ),
                            ),
                          ),
          ),
        );
      },
    );
  }
}
