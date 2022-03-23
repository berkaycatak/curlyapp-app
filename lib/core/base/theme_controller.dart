import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'theme_controller.g.dart';

class ThemeController = _ThemeControllerBase with _$ThemeController;

bool systemDark() => ThemeMode.system == ThemeMode.dark;

abstract class _ThemeControllerBase with Store {
  @observable
  ThemeData themeData = systemDark() ? ThemeData.dark() : ThemeData.light();

  @computed
  bool get isDark => themeData == ThemeData.dark();

  @action
  void changeTheme() {
    if (isDark) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }
  }
}
