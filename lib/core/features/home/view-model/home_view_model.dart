import 'dart:convert';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/drawer/model/Categories.dart';
import 'package:curlyapp/core/features/drawer/model/Pages.dart';
import 'package:curlyapp/core/features/drawer/model/Settings.dart';
import 'package:curlyapp/core/features/drawer/model/Social.dart';
import 'package:http/http.dart' as connection;
import 'package:curlyapp/core/features/home/model/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  List<Home> mansetData = [];
  @observable
  List<Home> mansetAltData = [];
  @observable
  List<Home> hikayeData = [];
  @observable
  List<Home> hikayeAltData = [];

  // drawer
  @observable
  List<Settings> settings = [];
  List<Pages> pages = [];
  List<Categories> categories = [];
  List<Social> social = [];

  var url = Uri.parse(WEBSITE_URL + '/wp-json/curlyapp/v1/posts');

  @observable
  String isServiceRequestLoading = STATUS_SUCCESS;

  /*
  @action
  void addData(List<Home> _manset, List<Home> _mansetAlt, List<Home> _hikaye,
      List<Home> _hikayeAlt) {
    mansetData = _manset;
    mansetAltData = _mansetAlt;
    hikayeData = _hikaye;
    hikayeAltData = _hikayeAlt;
  }*/

  @action
  void changeRequest(String string) {
    isServiceRequestLoading = string;
  }

  @action
  Future<List> getHomepage(int refresh) async {
    changeRequest(STATUS_LOADING);

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      if (refresh == 1) {
        mansetData = [];
        mansetAltData = [];
        hikayeData = [];
        hikayeAltData = [];
        pages = [];
        categories = [];
        social = [];
      }

      final cevap = await connection.get(url);
      final jsonresponse = json.decode(cevap.body);

      if (cevap.statusCode == 200) {
        try {
          // manset
          for (int i = 0; i < 4; i++) {
            mansetData.add(Home.fromJson(jsonresponse[0][i]));
          }
        } catch (e) {
          print(e);
        }
        try {
          // manset alt
          for (int i = 0; i < 4; i++) {
            mansetAltData.add(Home.fromJson(jsonresponse[1][i]));
          }
        } catch (e) {
          print(e);
        }
        try {
          // hikaye
          for (int i = 0; i < 4; i++) {
            hikayeData.add(Home.fromJson(jsonresponse[2][i]));
          }
        } catch (e) {
          print(e);
        }
        try {
          // hikaye alt
          for (int i = 0; i < 4; i++) {
            hikayeAltData.add(Home.fromJson(jsonresponse[3][i]));
          }
        } catch (e) {
          print(e);
        }

        // drawer
        try {
          // settings
          settings.add(Settings.fromJson(jsonresponse[4][0]));
        } catch (e) {
          print(e);
        }

        try {
          // pages
          for (int i = 0; i < 30; i++) {
            pages.add(Pages.fromJson(jsonresponse[5][i]));
          }
        } catch (e) {
          print(e);
        }

        try {
          // categories
          for (int i = 0; i < 30; i++) {
            categories.add(Categories.fromJson(jsonresponse[6][i]));
          }
        } catch (e) {
          print(e);
        }

        try {
          // social
          social.add(Social.fromJson(jsonresponse[7][0]));
        } catch (e) {
          print(e);
        }

        changeRequest(STATUS_SUCCESS);

        return [mansetData, mansetAltData, hikayeData, hikayeAltData];
      } else {
        changeRequest(STATUS_ERROR);
        return [mansetData, mansetAltData, hikayeData, hikayeAltData];
      }
    } else {
      changeRequest(STATUS_NO_INTERNET);
      return [mansetData, mansetAltData, hikayeData, hikayeAltData];
    }
  }
}
