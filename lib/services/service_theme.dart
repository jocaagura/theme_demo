import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeService = ThemeService();

class ThemeService extends ChangeNotifier {
  bool isDark = false;
  final ValueNotifier<ThemeData> _themeValuenotifier = ValueNotifier(
      customThemeFromColorScheme(
          lightColorScheme, GoogleFonts.robotoTextTheme()));

  ValueNotifier<ThemeData> get themeValuenotifier => _themeValuenotifier;

  ThemeData get theme => _themeValuenotifier.value;
  set theme(ThemeData themeData) {
    _themeValuenotifier.value = themeData;
  }

  void switchLightAndDarkTheme() {
    isDark = !isDark;
    isDark
        ? theme = customThemeFromColorScheme(darkColorScheme,
            GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme), isDark)
        : theme = customThemeFromColorScheme(
            lightColorScheme, GoogleFonts.robotoTextTheme());
    notifyListeners();
  }
}

MaterialColor materialColorFromRGB(int r, g, b) {
  MaterialColor colorJ = Colors.orange;
  try {
    Map<int, Color> colorMap = {
      50: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .55),
      100: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .45),
      200: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .35),
      300: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .25),
      400: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .1),
      500: Color.fromRGBO(r, g, b, 1.0),
      600: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .1),
      700: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .15),
      800: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .25),
      900: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .375),
    };

    colorJ = MaterialColor(
        int.parse(
            Color.fromRGBO(r, g, b, 1.0)
                .toString()
                .replaceAll('Color(', '')
                .replaceAll(')', '')
                .substring(2),
            radix: 16),
        colorMap);
  } catch (e) {
    colorJ = Colors.orange;
  }
  return colorJ;
}

/// get darker or ligther the color
Color getDarker(Color color, {double amount = .1}) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

Color getLighter(Color color, {double amount = .1}) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return hslLight.toColor();
}

ThemeData customThemeFromColorScheme(
    ColorScheme colorScheme, TextTheme textTheme,
    [bool isDark = false]) {
  return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: materialColorFromRGB(colorScheme.primary.red,
          colorScheme.primary.green, colorScheme.primary.blue));
}

class ThemeChangerWidget extends InheritedWidget {
  const ThemeChangerWidget(
      {required this.themeService, required Widget child, Key? key})
      : super(child: child, key: key);

  final ThemeService themeService;

  static ThemeChangerWidget of(BuildContext context) {
    final ThemeChangerWidget? result =
        context.dependOnInheritedWidgetOfExactType<ThemeChangerWidget>();
    assert(result != null, 'No ThemeChangerData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class ThemeHelpers {
  static Color colorRandom() {
    var random = Random();
    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  static bool validateHexColor(String colorHex) {
    bool colorValido = false;

    Pattern colorPattern = r'^#(?:[0-9a-fA-F]{3}){1,2}$';
    RegExp regExp = RegExp(colorPattern as String);
    if (regExp.hasMatch(colorHex)) {
      colorValido = true;
    }
    return colorValido;
  }

  /// get darker or ligther the color
  static Color getDarker(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color getLighter(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static MaterialColor materialColorFromRGB(int r, g, b) {
    MaterialColor colorJ = Colors.orange;
    try {
      Map<int, Color> colorMap = {
        50: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .55),
        100: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .45),
        200: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .35),
        300: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        400: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .1),
        500: Color.fromRGBO(r, g, b, 1.0),
        600: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .1),
        700: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .15),
        800: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        900: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .375),
      };

      colorJ = MaterialColor(
          int.parse(
              Color.fromRGBO(r, g, b, 1.0)
                  .toString()
                  .replaceAll('Color(', '')
                  .replaceAll(')', '')
                  .substring(2),
              radix: 16),
          colorMap);
    } catch (e) {
      colorJ = Colors.orange;
    }

    return colorJ;
  }

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA6C8FF),
    onPrimary: Color(0xFF003063),
    primaryContainer: Color(0xFF00468B),
    onPrimaryContainer: Color(0xFFD4E3FF),
    secondary: Color(0xFFBDC7DC),
    onSecondary: Color(0xFF273141),
    secondaryContainer: Color(0xFF3D4758),
    onSecondaryContainer: Color(0xFFD9E3F8),
    tertiary: Color(0xFFDBBDE1),
    onTertiary: Color(0xFF3E2845),
    tertiaryContainer: Color(0xFF563E5D),
    onTertiaryContainer: Color(0xFFF8D8FE),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1B1B1D),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1B1B1D),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF43474F),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8E919A),
    onInverseSurface: Color(0xFF1B1B1D),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF245FA7),
    shadow: Color(0xFF000000),
  );

  static MaterialColor materialColorFromColor(Color color) {
    return materialColorFromRGB(color.red, color.green, color.blue);
  }
}

/// Replace with content of file downloaded from material tool
const seed = Color(0xFF6750A4);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFB20089),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFD8EB),
  onPrimaryContainer: Color(0xFF3B002C),
  secondary: Color(0xFF006494),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCAE6FF),
  onSecondaryContainer: Color(0xFF001E30),
  tertiary: Color(0xFF373CFF),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE0E0FF),
  onTertiaryContainer: Color(0xFF02006D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF6FEFF),
  onBackground: Color(0xFF001F24),
  surface: Color(0xFFF6FEFF),
  onSurface: Color(0xFF001F24),
  surfaceVariant: Color(0xFFF0DEE5),
  onSurfaceVariant: Color(0xFF4F4349),
  outline: Color(0xFF81737A),
  onInverseSurface: Color(0xFFD0F8FF),
  inverseSurface: Color(0xFF00363D),
  inversePrimary: Color(0xFFFFAEDC),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB20089),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFAEDC),
  onPrimary: Color(0xFF600049),
  primaryContainer: Color(0xFF880068),
  onPrimaryContainer: Color(0xFFFFD8EB),
  secondary: Color(0xFF8DCDFF),
  onSecondary: Color(0xFF00344F),
  secondaryContainer: Color(0xFF004B70),
  onSecondaryContainer: Color(0xFFCAE6FF),
  tertiary: Color(0xFFBFC2FF),
  onTertiary: Color(0xFF0600AB),
  tertiaryContainer: Color(0xFF0D00EE),
  onTertiaryContainer: Color(0xFFE0E0FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F24),
  onBackground: Color(0xFF97F0FF),
  surface: Color(0xFF001F24),
  onSurface: Color(0xFF97F0FF),
  surfaceVariant: Color(0xFF4F4349),
  onSurfaceVariant: Color(0xFFD3C2C9),
  outline: Color(0xFF9C8D93),
  onInverseSurface: Color(0xFF001F24),
  inverseSurface: Color(0xFF97F0FF),
  inversePrimary: Color(0xFFB20089),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFAEDC),
);
