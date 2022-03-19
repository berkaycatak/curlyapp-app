import 'package:curlyapp/core/features/category/view/category_view.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            height: 40,
            child: Image.network(
              viewModel.mansetData[0].logoUrl ??
                  viewModel.mansetData[1].logoUrl ??
                  viewModel.mansetData[2].logoUrl ??
                  viewModel.mansetData[3].logoUrl ??
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
        body: RefreshIndicator(
          onRefresh: () => viewModel.getHomepage(1),
          child: viewModel.isServiceRequestLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 350,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              child: Image.asset("assets/images/story.gif"),
                              padding: EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                            ),
                            Image.asset("assets/images/story.gif")
                          ],
                        ),
                      ),
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
                    ],
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(viewModel.mansetData[0].catName ?? ''),
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
                                child: Text("Tümünü göster")),
                          ],
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.mansetData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedListItem(
                                index,
                                key: ValueKey<int>(index),
                                data: viewModel.mansetData[index],
                              );
                            },
                          ),
                        ),
                        Text(viewModel.mansetAltData[0].catName ?? ''),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.mansetAltData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedListItem(
                                index,
                                key: ValueKey<int>(index),
                                data: viewModel.mansetAltData[index],
                              );
                            },
                          ),
                        ),
                        Text(viewModel.hikayeData[0].catName ?? ''),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.hikayeData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedListItem(
                                index,
                                key: ValueKey<int>(index),
                                data: viewModel.hikayeData[index],
                              );
                            },
                          ),
                        ),
                        Text(viewModel.hikayeAltData[0].catName ?? ''),
                        SizedBox(
                          height: viewModel.hikayeAltData.length * 100,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.hikayeAltData.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("ll" +
                                  viewModel.hikayeAltData.length.toString());
                              return AnimatedListItem(
                                index,
                                key: ValueKey<int>(index),
                                data: viewModel.hikayeAltData[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Home data;
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
    _animate = false;
    _isStart = true;
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
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePostView(
                      singleData: widget.data,
                    )),
          ),
          child: Container(
            height: 100,
            width: 200,
            child: Card(
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
          ),
        ),
      ),
    );
  }
}
