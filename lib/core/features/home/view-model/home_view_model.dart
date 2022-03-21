import 'dart:convert';
import 'package:curlyapp/core/constants/constants.dart';
import 'package:http/http.dart' as connection;
import 'package:curlyapp/core/features/home/model/home.dart';
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
  var url = Uri.parse(WEBSITE_URL + '/wp-json/curlyapp/v1/posts');

  @observable
  bool isServiceRequestLoading = false;

  @action
  void addData(List<Home> _manset, List<Home> _mansetAlt, List<Home> _hikaye,
      List<Home> _hikayeAlt) {
    mansetData = _manset;
    mansetAltData = _mansetAlt;
    hikayeData = _hikaye;
    hikayeAltData = _hikayeAlt;
  }

  @action
  Future<List> getHomepage(int refresh) async {
    changeRequest();

    if (refresh == 1) {
      mansetData = [];
      mansetAltData = [];
      hikayeData = [];
    }

    final cevap = await connection.get(url);
    if (cevap.statusCode == 200) {
      try {
        // manset
        for (int i = 0; i < 10; i++) {
          final jsonresponse = json.decode(cevap
              .body); // boş gelirse sanırım bıradabir hata olusur die tahmin ediyorum ama neyse
          mansetData.add(Home.fromJson(jsonresponse[0][i]));
        }
      } catch (e) {
        print(e);
      }
      try {
        // manset alt
        for (int i = 0; i < 10; i++) {
          final jsonresponse = json.decode(cevap
              .body); // boş gelirse sanırım bıradabir hata olusur die tahmin ediyorum ama neyse
          mansetAltData.add(Home.fromJson(jsonresponse[1][i]));
        }
      } catch (e) {
        print(e);
      }
      try {
        // hikaye
        for (int i = 0; i < 10; i++) {
          final jsonresponse = json.decode(cevap
              .body); // boş gelirse sanırım bıradabir hata olusur die tahmin ediyorum ama neyse
          hikayeData.add(Home.fromJson(jsonresponse[2][i]));
        }
      } catch (e) {
        print(e);
      }
      try {
        // hikaye alt
        for (int i = 0; i < 10; i++) {
          final jsonresponse = json.decode(cevap
              .body); // boş gelirse sanırım bıradabir hata olusur die tahmin ediyorum ama neyse
          hikayeAltData.add(Home.fromJson(jsonresponse[3][i]));
        }
      } catch (e) {
        print(e);
      }
      changeRequest();
      print(mansetData.length);

      return [mansetData, mansetAltData, hikayeData, hikayeAltData];
    }
    changeRequest();

    return [mansetData, mansetAltData, hikayeData, hikayeAltData];
  }

  @action
  void changeRequest() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}
