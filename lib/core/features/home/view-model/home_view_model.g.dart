// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$mansetDataAtom = Atom(name: '_HomeViewModelBase.mansetData');

  @override
  List<Home> get mansetData {
    _$mansetDataAtom.reportRead();
    return super.mansetData;
  }

  @override
  set mansetData(List<Home> value) {
    _$mansetDataAtom.reportWrite(value, super.mansetData, () {
      super.mansetData = value;
    });
  }

  final _$mansetAltDataAtom = Atom(name: '_HomeViewModelBase.mansetAltData');

  @override
  List<Home> get mansetAltData {
    _$mansetAltDataAtom.reportRead();
    return super.mansetAltData;
  }

  @override
  set mansetAltData(List<Home> value) {
    _$mansetAltDataAtom.reportWrite(value, super.mansetAltData, () {
      super.mansetAltData = value;
    });
  }

  final _$hikayeDataAtom = Atom(name: '_HomeViewModelBase.hikayeData');

  @override
  List<Home> get hikayeData {
    _$hikayeDataAtom.reportRead();
    return super.hikayeData;
  }

  @override
  set hikayeData(List<Home> value) {
    _$hikayeDataAtom.reportWrite(value, super.hikayeData, () {
      super.hikayeData = value;
    });
  }

  final _$hikayeAltDataAtom = Atom(name: '_HomeViewModelBase.hikayeAltData');

  @override
  List<Home> get hikayeAltData {
    _$hikayeAltDataAtom.reportRead();
    return super.hikayeAltData;
  }

  @override
  set hikayeAltData(List<Home> value) {
    _$hikayeAltDataAtom.reportWrite(value, super.hikayeAltData, () {
      super.hikayeAltData = value;
    });
  }

  final _$settingsAtom = Atom(name: '_HomeViewModelBase.settings');

  @override
  List<Settings> get settings {
    _$settingsAtom.reportRead();
    return super.settings;
  }

  @override
  set settings(List<Settings> value) {
    _$settingsAtom.reportWrite(value, super.settings, () {
      super.settings = value;
    });
  }

  final _$isServiceRequestLoadingAtom =
      Atom(name: '_HomeViewModelBase.isServiceRequestLoading');

  @override
  String get isServiceRequestLoading {
    _$isServiceRequestLoadingAtom.reportRead();
    return super.isServiceRequestLoading;
  }

  @override
  set isServiceRequestLoading(String value) {
    _$isServiceRequestLoadingAtom
        .reportWrite(value, super.isServiceRequestLoading, () {
      super.isServiceRequestLoading = value;
    });
  }

  final _$getHomepageAsyncAction =
      AsyncAction('_HomeViewModelBase.getHomepage');

  @override
  Future<List<dynamic>> getHomepage(int refresh) {
    return _$getHomepageAsyncAction.run(() => super.getHomepage(refresh));
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void changeRequest(String string) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeRequest');
    try {
      return super.changeRequest(string);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mansetData: ${mansetData},
mansetAltData: ${mansetAltData},
hikayeData: ${hikayeData},
hikayeAltData: ${hikayeAltData},
settings: ${settings},
isServiceRequestLoading: ${isServiceRequestLoading}
    ''';
  }
}
