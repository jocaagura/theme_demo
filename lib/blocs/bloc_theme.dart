import 'dart:async';

import 'package:flutter/material.dart';

import '../services/service_theme.dart';

final blocTheme = BlocTheme(themeService);

class BlocTheme {
  BlocTheme(ThemeService themeService) {
    theme = themeService.theme;
  }

  final _themeController = StreamController<ThemeData>();

  ThemeData get theme => themeService.theme;

  set theme(ThemeData tmp) {
    _themeController.sink.add(tmp);
    themeService.theme = tmp;
  }

  Stream<ThemeData> get themeDataStream => _themeController.stream;

  void switchThemeBetweenLigthAndDark() {
    themeService.switchLightAndDarkTheme();
    theme = themeService.theme;
  }

  dispose() {
    _themeController.close();
  }
}
