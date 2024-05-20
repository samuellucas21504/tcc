import 'package:flutter/material.dart';
import 'package:tcc/constants/colors.dart';

class Themes {
  static final ThemeData main = ThemeData.dark().copyWith(
    primaryColor: ThemeColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.primary,
      shadowColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      foregroundColor: ThemeColors.onPrimary,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.primary,
      onPrimary: ThemeColors.onPrimary,
      secondary: ThemeColors.primary,
      onSecondary: ThemeColors.onPrimary,
      error: ThemeColors.error,
      onError: ThemeColors.onPrimary,
      background: ThemeColors.primary,
      onBackground: ThemeColors.onPrimary,
      surface: ThemeColors.surface,
      onSurface: ThemeColors.onPrimary,
      shadow: Colors.transparent,
      surfaceTint: ThemeColors.primary,
    ),
    scaffoldBackgroundColor: ThemeColors.primary,
    primaryColorDark: ThemeColors.primary,
    primaryColorLight: ThemeColors.primary,
    shadowColor: Colors.transparent,
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeColors.primary,
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
  );

  static themeWithTransparentDivider(BuildContext context) =>
      Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      );
}
