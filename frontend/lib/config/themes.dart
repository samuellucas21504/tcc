import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class Themes {
  static final ThemeData main = ThemeData.dark().copyWith(
    primaryColor: ThemeColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.background,
      shadowColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
      centerTitle: true,
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
      onSurface: ThemeColors.onSurface,
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
        iconColor: MaterialStatePropertyAll(ThemeColors.onSurface),
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      ),
    ),
    iconTheme: const IconThemeData(color: ThemeColors.surface),
    secondaryHeaderColor: ThemeColors.onSurface,
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
        color: ThemeColors.onSurface,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: TextStyle(color: ThemeColors.onSurface),
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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(MaterialState.disabled)
                ? ThemeColors.onBackground.withAlpha(50)
                : ThemeColors.onBackground,
            fontWeight: FontWeight.w500,
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled) ||
              states.contains(MaterialState.pressed)) {
            return ThemeColors.onBackground.withAlpha(40);
          }

          return ThemeColors.onBackground;
        }),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return ThemeColors.surface;
          }
          if (states.contains(MaterialState.disabled)) {
            return ThemeColors.onPrimary.withAlpha(40);
          }
          return ThemeColors.onPrimary;
        }),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(MaterialState.disabled)
                ? ThemeColors.onBackground
                : ThemeColors.background,
            fontWeight: FontWeight.w500,
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ThemeColors.onBackground;
          }
          if (states.contains(MaterialState.pressed)) {
            return ThemeColors.onBackground;
          }

          return ThemeColors.background;
        }),
      ),
    ),
    applyElevationOverlayColor: false,
    dialogTheme: const DialogTheme(
      backgroundColor: ThemeColors.surface,
      elevation: 0,
      shadowColor: Colors.transparent,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        color: ThemeColors.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      iconColor: ThemeColors.onSurface,
      contentTextStyle: TextStyle(color: ThemeColors.onSurface),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()}),
  );

  static themeWithTransparentDivider(BuildContext context) =>
      Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      );
}
