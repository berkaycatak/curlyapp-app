import 'dart:convert';

import 'package:http/http.dart' as connection;
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';
part 'category_view_model.g.dart';

class CategoryViewModel = _CategoryViewModelBase with _$CategoryViewModel;

abstract class _CategoryViewModelBase with Store {
  @observable
  List<Category> data = [];

  @observable
  int page = 1;

  @observable
  String isServiceRequestLoading = STATUS_SUCCESS;

  void changePage(int category) {
    page++;
    getData(category, 0);
  }

  @action
  void changeRequest(String string) {
    isServiceRequestLoading = string;
  }

  @action
  Future<List<Category>> getData(int category, int refresh) async {
    changeRequest(STATUS_LOADING);

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // internet var
      if (refresh == 1) data = [];
      var url = Uri.parse(WEBSITE_URL +
          '/wp-json/curlyapp/v1/category-posts' +
          "?category_id=" +
          category.toString() +
          "&page=" +
          page.toString());

      final cevap = await connection.get(url);
      if (cevap.statusCode == 200) {
        try {
          // manset
          final jsonresponse = json.decode(cevap.body);
          for (int i = 0; i < 30; i++) {
            data.add(Category.fromJson(jsonresponse[i]));
          }
        } catch (e) {
          print(e);
        }
      } else if (cevap.statusCode == 404) {
        changeRequest(STATUS_ERROR);
        return data;
      } else {
        changeRequest(STATUS_ERROR);
        return data;
      }

      changeRequest(STATUS_SUCCESS);
      return data;
    } // internet var
    else {
      changeRequest(STATUS_NO_INTERNET);
    }
    return data;
  }
}
