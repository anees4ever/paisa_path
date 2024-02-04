import 'package:paisa_path/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//==============
const appBarColorLight = Colors.lightBlue;
const appBarColorSecondaryLight = Color.fromARGB(255, 2, 103, 150);
const appBgColorLight = Colors.white;

const fontColorLight = Color.fromARGB(255, 14, 14, 8);
const fontColorHightlightLight = Colors.lightBlue;

const buttonDisabledLight = Colors.black54;

const inputBorderDisabledLight = Colors.white24;
const inputBorderEnabledLight = Color.fromARGB(255, 14, 14, 8);
const inputBorderFocusedLight = Colors.lightBlue;
//==============
const appBarColorDark = Color.fromARGB(255, 14, 14, 8);
const appBarColorSecondaryDark = Colors.white38;
const appBgColorDark = Color.fromARGB(255, 22, 22, 27);

const fontColorDark = Colors.white;
const fontColorHightlightDark = Colors.lightBlue;

const buttonDisabledDark = Colors.white54;

const inputBorderDisabledDark = Colors.white24;
const inputBorderEnabledDark = Colors.white;
const inputBorderFocusedDark = Colors.lightBlue;

const appBarColor = ThemedColor(
  light: Colors.lightBlue,
  dark: Color.fromARGB(255, 14, 14, 8),
);
const appBarColorSecondary = ThemedColor(
  light: Color.fromARGB(255, 2, 103, 150),
  dark: Colors.white38,
);
const appBgColor = ThemedColor(
  light: Colors.white70,
  dark: Color.fromARGB(255, 22, 22, 27),
);

const fontColor = ThemedColor(
  light: Color.fromARGB(255, 14, 14, 8),
  dark: Colors.white,
);

const fontColorError = ThemedColor(
  light: Color.fromARGB(255, 150, 29, 29),
  dark: Color.fromARGB(255, 228, 33, 33),
);

const buttonDisabled = ThemedColor(
  light: Colors.black54,
  dark: Colors.white54,
);

const cardBackground = ThemedColor(
  light: Colors.white70,
  dark: Colors.white12,
);

const inputBorderDisabled = ThemedColor(
  light: Colors.black26,
  dark: Colors.white24,
);
const inputBorderEnabled = ThemedColor(
  light: Color.fromARGB(255, 14, 14, 8),
  dark: Colors.white,
);
const inputBorderFocused = ThemedColor(
  light: Colors.lightBlue,
  dark: Colors.lightBlue,
);

const colorHighlightedItem = ThemedColor(
  light: Color.fromRGBO(27, 94, 32, 1),
  dark: Colors.greenAccent,
);

const colorPossitiveButton = ThemedColor(
  light: Color.fromRGBO(27, 94, 32, 1),
  dark: Colors.greenAccent,
);
const colorNegativeButton = ThemedColor(
  light: Colors.lightBlue,
  dark: Colors.lightBlue,
);

class ThemedColor {
  final Color light;
  final Color dark;

  const ThemedColor({required this.light, required this.dark});

  Color get theme {
    ThemeController controller = Get.find();
    return controller.currentThemeMode.value == ThemeMode.dark ? dark : light;
  }
}
