import 'package:curlyapp/core/features/category/view/category_view.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:curlyapp/core/widgets/animated_list_item.dart';
import 'package:curlyapp/core/widgets/categories_widget.dart';
import 'package:curlyapp/core/widgets/home_manset_widget.dart';
import 'package:curlyapp/core/widgets/last_article_story_widget.dart';
import 'package:curlyapp/core/widgets/list_article_widget.dart';
import 'package:curlyapp/core/widgets/loading/home_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
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
              viewModel.hikayeAltData[0].logoUrl ??
                  viewModel.hikayeAltData[1].logoUrl ??
                  viewModel.hikayeAltData[2].logoUrl ??
                  viewModel.hikayeAltData[3].logoUrl ??
                  "https://kisavoz.com/wp-content/uploads/2018/06/Ba%C5%9Fl%C4%B1ks%C4%B1z-1-3-1.jpg",
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
        drawer: Drawer(),
        body: RefreshIndicator(
          onRefresh: () => viewModel.getHomepage(1),
          child: viewModel.isServiceRequestLoading
              ? LoadingWidget()
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
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SinglePostView(
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
                                        .mansetData[index].thumbnailFull,
                                    title: viewModel.mansetData[index].title,
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.mansetData.length - 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0)
                                index = 1;
                              else
                                index++;
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SinglePostView(
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
                                        .mansetData[index].thumbnailFull,
                                    title: viewModel.mansetData[index].title,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // manşet bitis
                        // kategoriler
                        const CategoriesWidget(),
                        // kategoriler bitiş

                        // manşet alt
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.mansetAltData[0].catName ?? '',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryView(
                                      homeViewModel: viewModel,
                                      categoryId: 1,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Tümünü göster",
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: viewModel.hikayeData.length * 125,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.mansetAltData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SinglePostView(
                                      home_singleData:
                                          viewModel.mansetAltData[index],
                                    ),
                                  ),
                                ),
                                child: AnimatedListItem(index,
                                    key: ValueKey<int>(index),
                                    widget: ListArticleWidget(
                                      title:
                                          viewModel.mansetAltData[index].title,
                                      image: viewModel
                                          .mansetAltData[index].thumbnailFull,
                                      time: viewModel.mansetAltData[index].date,
                                      editor: viewModel
                                          .mansetAltData[index].authorName,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.hikayeData[0].catName ?? '',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryView(
                                      homeViewModel: viewModel,
                                      categoryId: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Tümünü göster",
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.hikayeData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SinglePostView(
                                        home_singleData:
                                            viewModel.hikayeData[index],
                                      ),
                                    ),
                                  ),
                                  child: AnimatedListItem(
                                    index,
                                    key: ValueKey<int>(index),
                                    widget: LastArticleStoryWidget(
                                      title: viewModel.hikayeData[index].title,
                                      image: viewModel
                                          .hikayeData[index].thumbnailFull,
                                      date: viewModel.hikayeData[index].date,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.hikayeAltData[0].catName ?? '',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryView(
                                      homeViewModel: viewModel,
                                      categoryId: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Tümünü göster",
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: viewModel.hikayeAltData.length * 100,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.hikayeAltData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SinglePostView(
                                      home_singleData:
                                          viewModel.hikayeAltData[index],
                                    ),
                                  ),
                                ),
                                child: AnimatedListItem(
                                  index,
                                  key: ValueKey<int>(index),
                                  widget: Container(
                                    height: 100,
                                    width: 200,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          viewModel.hikayeAltData[index].title
                                              .toString(),
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // hikaye alt bitiş
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
