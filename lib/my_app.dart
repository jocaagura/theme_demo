import 'package:flutter/material.dart';

import 'services/service_theme.dart';
import 'ui/pages/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeData = ValueNotifier<ThemeData>(
    //     ThemeChangerWidget.of(context).themeService.theme);
    return ValueListenableBuilder<ThemeData>(
      valueListenable:
          ThemeChangerWidget.of(context).themeService.themeValuenotifier,
      builder: (BuildContext context, ThemeData themeDataTmp, Widget? child) {
        return MaterialApp(
          title: 'Theme Demo',
          theme: themeDataTmp,
          home: MyHomePage(
            title: '${themeDataTmp.primaryColor.value}',
          ),
        );
      },
    );
  }
}
