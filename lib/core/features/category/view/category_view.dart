import 'package:admob_flutter/admob_flutter.dart';
import 'package:curlyapp/core/base/state/base_state.dart';
import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/error/view/error_404_view.dart';
import 'package:curlyapp/core/features/error/view/error_connection_view.dart';
import 'package:curlyapp/core/features/error/view/error_no_result_view.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:curlyapp/core/services/admob_service.dart';
import 'package:curlyapp/core/widgets/animated_list_item.dart';
import 'package:curlyapp/core/widgets/category_first_item_widget.dart';
import 'package:curlyapp/core/widgets/list_article_widget.dart';
import 'package:curlyapp/core/widgets/loading/category_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
    widget._categoryViewModel.getData(widget.categoryId, 0);
    WidgetsFlutterBinding.ensureInitialized();
    Admob.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 30,
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
            return CategoryLoadingWidget(
                themeDataController: widget.themeController);
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
                        child: Column(
                          children: [
                            AnimatedListItem(
                              index,
                              key: ValueKey<int>(index),
                              widget: CategoryFirstItemWidget(
                                image: widget._categoryViewModel.data[index]
                                    .thumbnailFull,
                                title:
                                    widget._categoryViewModel.data[index].title,
                                date:
                                    widget._categoryViewModel.data[index].date,
                                categoryName: widget
                                    ._categoryViewModel.data[index].catName,
                                content: widget
                                    ._categoryViewModel.data[index].icerik,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 10, bottom: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.LARGE_BANNER,
                                ),
                              ),
                            ),
                          ],
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
                        child: Column(
                          children: [
                            AnimatedListItem(
                              index,
                              key: ValueKey<int>(index),
                              widget: ListArticleWidget(
                                title:
                                    widget._categoryViewModel.data[index].title,
                                image: widget._categoryViewModel.data[index]
                                    .thumbnailFull,
                                time:
                                    widget._categoryViewModel.data[index].date,
                                editor: widget
                                    ._categoryViewModel.data[index].authorName,
                                darkMode: widget.themeController.isDark,
                              ),
                            ),
                            index % 5 == 0
                                ? Column(
                                    children: [
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 10,
                                            bottom: 10),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: AdmobBanner(
                                            adUnitId: ams.getBannerAdId(),
                                            adSize:
                                                AdmobBannerSize.LARGE_BANNER,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                          ],
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
