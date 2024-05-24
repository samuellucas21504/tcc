import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class Themes {
  static final ThemeData main = ThemeData.dark().copyWith(
    primaryColor: ThemeColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.background,
      shadowColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      foregroundColor: ThemeColors.background,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.primary,
      onPrimary: ThemeColors.onPrimary,
      secondary: ThemeColors.surface,
      onSecondary: ThemeColors.onPrimary,
      error: ThemeColors.error,
      onError: ThemeColors.onPrimary,
      background: ThemeColors.background,
      onBackground: ThemeColors.onBackground,
      surface: ThemeColors.surface,
      onSurface: ThemeColors.onPrimary,
      shadow: Colors.transparent,
      surfaceTint: ThemeColors.primary,
    ),
    scaffoldBackgroundColor: ThemeColors.background,
    primaryColorDark: ThemeColors.primary,
    primaryColorLight: ThemeColors.primary,
    shadowColor: Colors.transparent,
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeColors.surface,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    canvasColor: ThemeColors.primary,
    cardColor: ThemeColors.primary,
    hintColor: ThemeColors.primary,
    secondaryHeaderColor: ThemeColors.primary,
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(color: ThemeColors.onPrimary),
      displayMedium: TextStyle(color: ThemeColors.onPrimary),
      displaySmall: TextStyle(color: ThemeColors.onPrimary),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: ThemeColors.surface,
    ),
    dividerTheme: const DividerThemeData(thickness: 0.5),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.surface, width: 1),
        borderRadius: BorderRadius.zero,
        gapPadding: 4,
      ),
      hintStyle: TextStyle(
        color: ThemeColors.surface,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.surface, width: 1),
        borderRadius: BorderRadius.zero,
        gapPadding: 4,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
  );

  static themeWithTransparentDivider(BuildContext context) =>
      Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      );
}
