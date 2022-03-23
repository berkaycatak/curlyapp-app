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
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          //backgroundColor: Color.fromARGB(255, 35, 37, 51),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => viewModel.getHomepage(1),
              ),
            ],
            centerTitle: true,
            title: SizedBox(
              height: 30,
              child: Image.network(
                viewModel.settings[0].logoUrl ?? TRANSPARENT_IMAGE_URL,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color.fromARGB(255, 224, 116, 15),
                      Color.fromARGB(255, 253, 30, 168),
                    ]),
              ),
            ),
          ),
          drawer: MyHomePage(homeViewModel: viewModel),
          body: RefreshIndicator(
            onRefresh: () => viewModel.getHomepage(1),
            child: (viewModel.isServiceRequestLoading == STATUS_LOADING)
                ? LoadingWidget()
                : (viewModel.isServiceRequestLoading == STATUS_ERROR)
                    ? Error404View()
                    : (viewModel.isServiceRequestLoading == STATUS_NO_INTERNET)
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
                                                home_singleData:
                                                    viewModel.mansetData[index],
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(
                                            index,
                                            key: ValueKey<int>(index),
                                            widget: HomeMansetWidget(
                                              fullSize: true,
                                              imageUrl: viewModel
                                                  .mansetData[index]
                                                  .thumbnailFull,
                                              title: viewModel
                                                  .mansetData[index].title,
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
                                          viewModel.mansetData.length - 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0)
                                          index = 1;
                                        else
                                          index++;
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostView(
                                                home_singleData:
                                                    viewModel.mansetData[index],
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(
                                            index,
                                            key: ValueKey<int>(index),
                                            widget: HomeMansetWidget(
                                              fullSize: false,
                                              imageUrl: viewModel
                                                  .mansetData[index]
                                                  .thumbnailFull,
                                              title: viewModel
                                                  .mansetData[index].title,
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
                                          viewModel.mansetAltData[0].catName ??
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
                                                homeViewModel: viewModel,
                                                categoryId: viewModel
                                                        .mansetAltData[0]
                                                        .catId ??
                                                    1,
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
                                    height: viewModel.hikayeData.length * 125,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel.mansetAltData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostView(
                                                home_singleData: viewModel
                                                    .mansetAltData[index],
                                              ),
                                            ),
                                          ),
                                          child: AnimatedListItem(index,
                                              key: ValueKey<int>(index),
                                              widget: ListArticleWidget(
                                                title: viewModel
                                                    .mansetAltData[index].title,
                                                image: viewModel
                                                    .mansetAltData[index]
                                                    .thumbnailFull,
                                                time: viewModel
                                                    .mansetAltData[index].date,
                                                editor: viewModel
                                                    .mansetAltData[index]
                                                    .authorName,
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
                                          viewModel.hikayeData[0].catName ?? "",
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
                                                homeViewModel: viewModel,
                                                categoryId: viewModel
                                                        .hikayeData[0].catId ??
                                                    1,
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
                                        itemCount: viewModel.hikayeData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SinglePostView(
                                                  home_singleData: viewModel
                                                      .hikayeData[index],
                                                ),
                                              ),
                                            ),
                                            child: AnimatedListItem(
                                              index,
                                              key: ValueKey<int>(index),
                                              widget: LastArticleStoryWidget(
                                                title: viewModel
                                                    .hikayeData[index].title,
                                                image: viewModel
                                                    .hikayeData[index]
                                                    .thumbnailFull,
                                                date: viewModel
                                                    .hikayeData[index].date,
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
                                          viewModel.hikayeAltData[0].catName ??
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
                                                homeViewModel: viewModel,
                                                categoryId: viewModel
                                                        .hikayeAltData[0]
                                                        .catId ??
                                                    1,
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
                                        itemCount:
                                            viewModel.hikayeAltData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SinglePostView(
                                                  home_singleData: viewModel
                                                      .hikayeAltData[index],
                                                ),
                                              ),
                                            ),
                                            child: AnimatedListItem(
                                              index,
                                              key: ValueKey<int>(index),
                                              widget: BottomStoryArticleWidget(
                                                title: viewModel
                                                    .hikayeAltData[index].title,
                                                image: viewModel
                                                    .hikayeAltData[index]
                                                    .thumbnailFull,
                                                date: viewModel
                                                    .hikayeAltData[index].date,
                                                author: viewModel
                                                    .hikayeAltData[index]
                                                    .authorName,
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
