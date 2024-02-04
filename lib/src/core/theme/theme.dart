import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primaryColor: appBgColorLight,
        colorScheme: const ColorScheme.light().copyWith(
          primary: appBarColorLight,
          secondary: appBarColorLight,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: appBarColorLight,
          titleTextStyle: GoogleFonts.archivoBlack(
            color: fontColorDark,
            fontSize: 16,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: appBarColorLight,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(fontColorDark),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return buttonDisabledLight;
              }
              return appBarColorLight;
            }),
            foregroundColor: MaterialStateProperty.all(appBgColorLight),
            overlayColor: MaterialStateProperty.all(
              appBgColorLight.withAlpha(100),
            ),
            iconColor: MaterialStateProperty.all(appBgColorLight),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(appBarColorLight),
            overlayColor: MaterialStateProperty.all(
              fontColorLight.withAlpha(60),
            ),
            iconColor: MaterialStateProperty.all(appBarColorLight),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return fontColorHightlightLight;
              }
              return buttonDisabledLight;
            },
          ),
          thumbColor: MaterialStateProperty.all(appBgColorLight),
        ),
        scaffoldBackgroundColor: appBgColorLight, //page content area
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          displayColor: fontColorLight,
          bodyColor: fontColorLight,
        ),
        canvasColor: appBgColorLight, //reset of the area / drawer

        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: inputBorderDisabledLight,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: inputBorderEnabledLight,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: inputBorderFocusedLight,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIconColor: fontColorLight,
          prefixIconColor: fontColorLight,
          labelStyle: const TextStyle(
            color: fontColorLight,
          ),
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
            color: fontColorLight,
          ),
          floatingLabelStyle: const TextStyle(
            color: fontColorLight,
          ),
          iconColor: fontColorLight,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        ),
        iconTheme: const IconThemeData(
          color: fontColorLight,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: fontColorLight,
          color: appBarColorLight,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: fontColorDark,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: appBarColorLight,
          foregroundColor: appBgColorLight,
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
        primaryColor: appBgColorDark,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: appBarColorDark,
          secondary: appBgColorDark,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: appBarColorDark,
          titleTextStyle: GoogleFonts.archivoBlack(
            color: fontColorDark,
            fontSize: 16,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: fontColorDark,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(fontColorDark),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return buttonDisabledDark;
              }
              return fontColorDark;
            }),
            foregroundColor: MaterialStateProperty.all(appBgColorDark),
            overlayColor: MaterialStateProperty.all(
              appBgColorDark.withAlpha(100),
            ),
            iconColor: MaterialStateProperty.all(appBgColorDark),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(fontColorHightlightDark),
            overlayColor: MaterialStateProperty.all(
              fontColorDark.withAlpha(60),
            ),
            iconColor: MaterialStateProperty.all(fontColorDark),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return fontColorHightlightDark;
              }
              return buttonDisabledDark;
            },
          ),
          thumbColor: MaterialStateProperty.all(fontColorDark),
        ),
        scaffoldBackgroundColor: appBgColorDark, //page content area
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          displayColor: fontColorDark,
          bodyColor: fontColorDark,
        ),
        canvasColor: appBarColorDark,

        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: inputBorderDisabledDark,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: inputBorderEnabledDark,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: inputBorderFocusedDark,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIconColor: fontColorDark,
          prefixIconColor: fontColorDark,
          labelStyle: const TextStyle(
            color: fontColorDark,
          ),
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
            color: fontColorDark,
          ),
          floatingLabelStyle: const TextStyle(
            color: fontColorDark,
          ),
          iconColor: fontColorDark,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        ),
        iconTheme: const IconThemeData(
          color: fontColorDark,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: appBarColorDark,
          color: fontColorDark,
        ), //reset of the area / drawer
        bottomAppBarTheme: const BottomAppBarTheme(
          color: appBgColorDark,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: fontColorDark,
          foregroundColor: fontColorHightlightDark,
        ),
      );
}
