
import 'package:test/test.dart';
import 'package:theme_demo/services/service_theme.dart';

void main() {
  group('Service theme test', () {
    test('Initial value isDark', () {
      final themeService = ThemeService();
      expect(themeService.isDark, false);
    });

    test('Changing dark value to true', () {
      final themeService = ThemeService();
      themeService.isDark = true;
      expect(themeService.isDark, true);
    });


  });
}
