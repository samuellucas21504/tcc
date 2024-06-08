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
      secondary: ThemeColors.onBackground,
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
    primaryIconTheme: const IconThemeData(color: ThemeColors.surface),
    shadowColor: Colors.transparent,
    drawerTheme: DrawerThemeData(
      backgroundColor: ThemeColors.background,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrimColor: Colors.black.withAlpha(135),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: VisualDensity.compact,
    ),
    canvasColor: ThemeColors.primary,
    cardColor: ThemeColors.primary,
    hintColor: ThemeColors.primary,
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(ThemeColors.highlight),
      ),
    ),
    iconTheme: const IconThemeData(color: ThemeColors.surface),
    secondaryHeaderColor: ThemeColors.surface,
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(color: ThemeColors.onPrimary),
      displayMedium: TextStyle(color: ThemeColors.onPrimary),
      displaySmall: TextStyle(color: ThemeColors.onPrimary),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: ThemeColors.onBackground,
    ),
    dividerTheme: const DividerThemeData(thickness: 0.5),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.onBackground, width: 1),
        borderRadius: BorderRadius.zero,
        gapPadding: 4,
      ),
      hintStyle: TextStyle(
          color: ThemeColors.onBackground, fontWeight: FontWeight.w400),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: TextStyle(color: ThemeColors.onBackground),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.onBackground, width: 1),
        borderRadius: BorderRadius.zero,
        gapPadding: 4,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: ThemeColors.onBackground,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: ThemeColors.onBackground,
        textStyle: const TextStyle(
          color: ThemeColors.background,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: ThemeColors.background,
        disabledForegroundColor: ThemeColors.background,
      ),
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
