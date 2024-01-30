// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LanguageGenerator
// **************************************************************************

// DO NOT EDIT. This is code generated via package:flutter_lang
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:paisa_path/src/localization/flutter_lang.lang.g.dart';

abstract class FlutterLanguage {
  FlutterLanguage(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FlutterLanguage of(BuildContext context) {
    return Localizations.of<FlutterLanguage>(context, FlutterLanguage) ??
        FlutterLanguageEN();
  }

  static const LocalizationsDelegate<FlutterLanguage> delegate =
      _FlutterLanguageDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'hi': 'Hindi',
  };

  /// Application title
  ///
  /// [en]: **'Paisa Path'**
  String get appName;

  /// A label on the button to change language
  ///
  /// [en]: **'Change Language'**
  String get changeLanguage;

  /// A label to show the current language
  ///
  /// [en]: **'Your language is set to %s'**
  String get yourLanguageIsSetTo;

  /// Title of expense entry screen
  ///
  /// [en]: **'Expense Entry'**
  String get expenseEntry;

  /// [en]: **'Amount'**
  String get amount;

  /// [en]: **'Description'**
  String get description;

  /// Save button label
  ///
  /// [en]: **'Save'**
  String get save;

  /// Update button label
  ///
  /// [en]: **'Update'**
  String get update;

  /// Type of Expense label in expense entry screen
  ///
  /// [en]: **'Type'**
  String get type;

  /// [en]: **'Delete'**
  String get delete;

  /// [en]: **'Cancel'**
  String get cancel;

  /// [en]: **'Not selected'**
  String get notSelected;

  /// Expense delete confirmation dialog title
  ///
  /// [en]: **'Delete Expense?'**
  String get deleteExpense;

  /// Expense delete confirmation dialog message
  ///
  /// [en]: **'Are you sure to delete this expense (%s)?'**
  String get deleteExpenseMessage;

  /// [en]: **'Sort'**
  String get sort;

  /// [en]: **'Total'**
  String get total;

  /// [en]: **'Filter'**
  String get filter;

  /// [en]: **'Today'**
  String get today;

  /// [en]: **'Yesterday'**
  String get yesterday;

  /// [en]: **'This Week'**
  String get thisWeek;

  /// [en]: **'Last Week'**
  String get lastWeek;

  /// [en]: **'This Month'**
  String get thisMonth;

  /// [en]: **'Last Month'**
  String get lastMonth;

  /// [en]: **'This Year'**
  String get thisYear;

  /// [en]: **'Last Year'**
  String get lastYear;

  /// [en]: **'All Time'**
  String get allTime;

  /// [en]: **'Custom'**
  String get custom;

  /// [en]: **'From'**
  String get from;

  /// [en]: **'To'**
  String get to;

  /// [en]: **'View All'**
  String get viewAll;

  /// [en]: **'Expenses'**
  String get expenses;

  /// [en]: **'Others'**
  String get others;

  /// [en]: **'Uncategorized'**
  String get uncategorized;

  /// [en]: **'No expenses yet. Keep it up!'**
  String get noExpenses;
}

class _FlutterLanguageDelegate extends LocalizationsDelegate<FlutterLanguage> {
  const _FlutterLanguageDelegate();

  @override
  Future<FlutterLanguage> load(Locale locale) {
    return SynchronousFuture<FlutterLanguage>(readFlutterLanguage(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'hi',
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_FlutterLanguageDelegate old) => false;
}

FlutterLanguage readFlutterLanguage(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return FlutterLanguageEN();
    case 'hi':
      return FlutterLanguageHI();
    default:
      return FlutterLanguageEN();
  }
}
