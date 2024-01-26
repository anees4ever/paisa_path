import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/database/floor_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalsController extends GetxController {
  late AppDatabase _database;
  late SharedPreferences _prefs;

  AppDatabase get database => _database;
  SharedPreferences get prefs => _prefs;

  String get languageCode => prefs.getString('locale') ?? 'en';
  set languageCode(String value) => prefs.setString('locale', value);

  Locale get locale => Locale(languageCode);

  initDb() async {
    _database = await getFloorDatabase();
  }

  initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
