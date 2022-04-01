import 'package:curlyapp/core/base/theme_controller.dart';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/error/view/error_404_view.dart';
import 'package:curlyapp/core/features/error/view/error_connection_view.dart';
import 'package:curlyapp/core/features/error/view/error_no_result_view.dart';
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/home/view/home_view.dart';
import 'package:curlyapp/core/widgets/loading/category_loading_widget.dart';
import 'package:curlyapp/core/widgets/loading/home_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

Future<List> data = [] as Future<List>;

class SplashView extends StatefulWidget {
  final _viewModel = HomeViewModel();
  final ThemeController themeDataController;

  SplashView({Key? key, required this.themeDataController}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void tryAction() {
    widget._viewModel.getHomepage(0).then((value) {
      print(widget._viewModel.isServiceRequestLoading);
      if (widget._viewModel.isServiceRequestLoading == STATUS_SUCCESS) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeView(
              viewModel: widget._viewModel,
              themeDataController: widget.themeDataController,
            ),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tryAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (widget._viewModel.isServiceRequestLoading == STATUS_LOADING) {
            return Container(
              color: Colors.blue,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (widget._viewModel.isServiceRequestLoading ==
              STATUS_ERROR) {
            return Error404View();
          } else if (widget._viewModel.isServiceRequestLoading ==
              STATUS_NO_INTERNET) {
            return ErrorConnectionView();
          } else if (widget._viewModel.mansetData.isEmpty ||
              widget._viewModel.mansetAltData.isEmpty ||
              widget._viewModel.hikayeData.isEmpty ||
              widget._viewModel.hikayeAltData.isEmpty) {
            return ErrorNoResultView(
              widget: FlatButton(
                color: Color(0xFF6B92F2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () => tryAction(),
                child: Text(
                  "Tekrar Dene".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            return LoadingWidget(
                themeDataController: widget.themeDataController);
          }
        },
      ),
    );
  }
}
