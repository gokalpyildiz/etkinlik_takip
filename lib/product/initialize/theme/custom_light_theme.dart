import 'package:etkinlik_takip/product/constants/ui/ui_constants.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_color_scheme.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_theme.dart';
import 'package:flutter/material.dart';

/// Custom light theme for project design
final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
    //xx =>dont change because is used
    fontFamily: UiConstants.appFontFamily().fontFamily,
    colorScheme: CustomColorScheme.lightColorScheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    dividerColor: const Color.fromRGBO(209, 213, 219, 1),
    hintColor: const Color.fromRGBO(136, 140, 147, 1),
  );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData => const FloatingActionButtonThemeData();
}
