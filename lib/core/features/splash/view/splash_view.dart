import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:curlyapp/core/features/home/view-model/home_view_model.dart';
import 'package:curlyapp/core/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

Future<List> data = [] as Future<List>;

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _viewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _viewModel.getHomepage().then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeView(
            viewModel: _viewModel,
          ),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    ));
  }
}
