import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:curlyapp/core/widgets/animated_list_item.dart';
import 'package:curlyapp/core/widgets/list_article_widget.dart';
import 'package:curlyapp/core/widgets/loading/category_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryView extends StatefulWidget {
  final int categoryId;

  final HomeViewModel homeViewModel;

  final _categoryViewModel = CategoryViewModel();

  CategoryView(
      {Key? key, required this.categoryId, required this.homeViewModel})
      : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    widget._categoryViewModel.getData(widget.categoryId, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: Image.network(
            widget.homeViewModel.mansetData[0].logoUrl ??
                widget.homeViewModel.mansetData[1].logoUrl ??
                widget.homeViewModel.mansetData[2].logoUrl ??
                widget.homeViewModel.mansetData[3].logoUrl ??
                "https://kisavoz.com/wp-content/uploads/2018/06/Ba%C5%9Fl%C4%B1ks%C4%B1z-1-3-1.jpg",
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Observer(builder: (_) {
        return widget._categoryViewModel.isServiceRequestLoading
            ? const CategoryLoadingWidget()
            : RefreshIndicator(
                onRefresh: () =>
                    widget._categoryViewModel.getData(widget.categoryId, 1),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget._categoryViewModel.data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget._categoryViewModel.data.length == index) {
                      return GestureDetector(
                        onTap: (() => widget._categoryViewModel
                            .changePage(widget.categoryId)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightBlueAccent,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Devamını yükle...",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (index == 0) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePostView(
                              category_singleData:
                                  widget._categoryViewModel.data[index],
                            ),
                          ),
                        ),
                        child: AnimatedListItem(
                          index,
                          key: ValueKey<int>(index),
                          widget: CategoryFirstItemWidget(
                            image: widget
                                ._categoryViewModel.data[index].thumbnailFull,
                            title: widget._categoryViewModel.data[index].title,
                            date: widget._categoryViewModel.data[index].date,
                            categoryName:
                                widget._categoryViewModel.data[index].catName,
                            content:
                                widget._categoryViewModel.data[index].icerik,
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePostView(
                              category_singleData:
                                  widget._categoryViewModel.data[index],
                            ),
                          ),
                        ),
                        child: AnimatedListItem(
                          index,
                          key: ValueKey<int>(index),
                          widget: ListArticleWidget(
                            title: widget._categoryViewModel.data[index].title,
                            image: widget
                                ._categoryViewModel.data[index].thumbnailFull,
                            time: widget._categoryViewModel.data[index].date,
                            editor: widget
                                ._categoryViewModel.data[index].authorName,
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              );
      }),
    );
  }
}

class CategoryFirstItemWidget extends StatelessWidget {
  final image, title, categoryName, date, content;
  const CategoryFirstItemWidget(
      {Key? key,
      this.image,
      this.title,
      this.categoryName,
      this.date,
      this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Stack(
        children: [
          Image.network(
            image,
            height: 350,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(199, 0, 0, 0)
                ],
                stops: [0, 0.6],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 350,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 250, 18, 2),
                      ),
                      child: Text(
                        categoryName,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15),
                child: Html(
                  data: content + "...",
                  style: {
                    "body": Style(
                      color: Color.fromARGB(255, 190, 190, 190),
                      padding: EdgeInsets.zero,
                      maxLines: 3,
                      textDecorationThickness: 0,
                      fontSize: FontSize.rem(1),
                    ),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("diğer"),
    );
  }
}
