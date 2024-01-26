import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rxn<ThemeMode> currentThemeMode = Rxn<ThemeMode>(ThemeMode.light);
  SharedPreferences? prefs;

  @override
  onInit() {
    super.onInit();
    _getPref().then((pref) async {
      String value = pref.getString('theme_mode') ?? 'L';
      if (value == 'D') {
        currentThemeMode(ThemeMode.dark);
      } else {
        currentThemeMode(ThemeMode.light);
      }
    });
  }

  Future<SharedPreferences> _getPref() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  toggleTheme() {
    currentThemeMode(currentThemeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light);
    _getPref().then((pref) {
      pref.setString(
          'theme_mode', currentThemeMode.value == ThemeMode.dark ? 'D' : 'L');
    });
  }
}
