import 'package:flutter/material.dart';

import 'my_app.dart';
import 'services/service_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ThemeChangerWidget(themeService: ThemeService(), child: const MyApp()));
}
