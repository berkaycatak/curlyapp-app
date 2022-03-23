import 'package:curlyapp/core/base/state/base_state.dart';
import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/error/view/error_404_view.dart';
import 'package:curlyapp/core/features/error/view/error_connection_view.dart';
import 'package:curlyapp/core/features/error/view/error_no_result_view.dart';
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
  final ThemeController themeController;

  CategoryView(
      {Key? key,
      required this.categoryId,
      required this.homeViewModel,
      required this.themeController})
      : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends BaseState<CategoryView> {
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
            widget.homeViewModel.settings[0].logoUrl ?? TRANSPARENT_IMAGE_URL,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () =>
                widget._categoryViewModel.getData(widget.categoryId, 1),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (widget._categoryViewModel.isServiceRequestLoading ==
              STATUS_LOADING) {
            return const CategoryLoadingWidget();
          } else if (widget._categoryViewModel.isServiceRequestLoading ==
              STATUS_ERROR) {
            return Error404View();
          } else if (widget._categoryViewModel.isServiceRequestLoading ==
              STATUS_NO_INTERNET) {
            return ErrorConnectionView();
          } else {
            if (widget._categoryViewModel.data.length == 0) {
              return ErrorNoResultView(
                widget: FlatButton(
                  color: Color(0xFF6B92F2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () =>
                      widget._categoryViewModel.getData(widget.categoryId, 1),
                  child: Text(
                    "Tekrar Dene".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
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
                              themeController: widget.themeController,
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
                              themeController: widget.themeController,
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
            }
          }
        },
      ),
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
    String _content = content;
    if (_content.length > 200) _content = _content.substring(0, 200);
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
            ),
            height: 350,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  data: _content + "...",
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
