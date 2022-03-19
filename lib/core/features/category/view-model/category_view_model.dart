import 'dart:convert';

import 'package:http/http.dart' as connection;
import 'package:curlyapp/core/constants/constants.dart';
import 'package:curlyapp/core/features/category/model/category.dart';
import 'package:mobx/mobx.dart';
part 'category_view_model.g.dart';

class CategoryViewModel = _CategoryViewModelBase with _$CategoryViewModel;

abstract class _CategoryViewModelBase with Store {
  @observable
  List<Category> data = [];

  @observable
  int page = 1;

  @observable
  bool isServiceRequestLoading = false;

  @action
  Future<List<Category>> getData(int category, int refresh) async {
    if (refresh == 1) {
      data = [];
    }

    changeRequest();
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
        for (int i = 0; i < 10; i++) {
          data.add(Category.fromJson(jsonresponse[i]));
        }
      } catch (e) {
        if (refresh != 1) changeRequest();
        print(e);
        return data;
      }
    }

    changeRequest();
    return data;
  }

  void changePage(int category) {
    page++;
    getData(category, 0);
  }

  @action
  void changeRequest() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}
