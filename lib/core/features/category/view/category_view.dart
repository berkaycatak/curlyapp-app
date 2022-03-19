import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:curlyapp/core/features/category/view-model/category_view_model.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

    print(widget._categoryViewModel.isServiceRequestLoading.toString());
    print(widget.categoryId);

    widget._categoryViewModel.getData(widget.categoryId, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 204, 75, 0),
                  Color.fromARGB(255, 253, 30, 168),
                ]),
          ),
        ),
      ),
      body: Observer(builder: (_) {
        return widget._categoryViewModel.isServiceRequestLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/single.gif",
                      ),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/single.gif",
                      ),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 10),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/single.gif",
                      ),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 10),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/single.gif",
                      ),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 10),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () =>
                    widget._categoryViewModel.getData(widget.categoryId, 1),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget._categoryViewModel.data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return widget._categoryViewModel.data.length == index
                        ? GestureDetector(
                            onTap: (() => widget._categoryViewModel
                                .changePage(widget.categoryId)),
                            child: Text("devamı"),
                          )
                        : AnimatedListItem(
                            index,
                            key: ValueKey<int>(index),
                            data: widget._categoryViewModel.data[index],
                          );
                  },
                ),
              );
      }),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Category data;
  AnimatedListItem(this.index, {Key? key, required this.data})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    _isStart = true;
    _animate = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeIn,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image.network(widget.data.thumbnailFull ?? ""),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.data.title.toString(),
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
