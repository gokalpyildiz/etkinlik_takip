import 'package:etkinlik_takip/product/initialize/theme/custom_color_scheme.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_theme.dart';
import 'package:flutter/material.dart';

/// Custom light theme for project design
final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(colorScheme: CustomColorScheme.darkColorScheme, floatingActionButtonTheme: floatingActionButtonThemeData);

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
