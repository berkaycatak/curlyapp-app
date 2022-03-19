import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/single-post/view/single_post_view.dart';
import 'package:curlyapp/core/features/splash/view/splash_view.dart';
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
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromARGB(255, 105, 39, 143),
                    Color.fromARGB(255, 243, 33, 61),
                  ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => viewModel.getHomepage()),
        ),
        body: RefreshIndicator(
          onRefresh: () => viewModel.getHomepage(),
          child: viewModel.isServiceRequestLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(viewModel.mansetData[0].catName ?? ''),
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
                          height: 350,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.hikayeAltData.length,
                            itemBuilder: (BuildContext context, int index) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
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
