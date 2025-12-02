import 'package:chat_app/src/core/theme/app_color.dart';
import 'package:chat_app/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

final lightColorScheme = AppColorPalette.createColorScheme(
  appLight,
  isDark: false,
);
final darkColorScheme = AppColorPalette.createColorScheme(
  appDark,
  isDark: true,
);

class TAppTheme {
  TAppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    colorScheme: AppColorPalette.createColorScheme(appLight, isDark: false),
    scaffoldBackgroundColor: appLight.background,
    cardColor: appLight.card,
    textTheme: TTextTheme.lightTheme(lightColorScheme),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    colorScheme: AppColorPalette.createColorScheme(appDark, isDark: true),
    scaffoldBackgroundColor: appDark.background,
    cardColor: appDark.card,
    textTheme: TTextTheme.darkTheme(darkColorScheme),
  );
}
