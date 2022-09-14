import 'package:flutter/material.dart';
import 'package:theme_demo/blocs/bloc_theme.dart';

import 'ui/pages/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
        stream: blocTheme.themeDataStream,
        builder: (context, snapshot) {
          print('nowhere');
          return MaterialApp(
            title: 'Theme Demo',
            theme: blocTheme.theme,
            home: MyHomePage(
              title: '${blocTheme.theme.primaryColor.value}',
            ),
          );
        });
  }
}
