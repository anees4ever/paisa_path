import 'package:paisa_path/src/core/localization/flutter_lang.dart';

enum FilterDateTypes {
  any,
  today,
  yesterday,
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
  thisYear,
  lastYear,
  custom;

  String get label {
    switch (this) {
      case FilterDateTypes.any:
        return Strings.current.allTime;
      case FilterDateTypes.today:
        return Strings.current.today;
      case FilterDateTypes.yesterday:
        return Strings.current.yesterday;
      case FilterDateTypes.thisWeek:
        return Strings.current.thisWeek;
      case FilterDateTypes.lastWeek:
        return Strings.current.lastWeek;
      case FilterDateTypes.thisMonth:
        return Strings.current.thisMonth;
      case FilterDateTypes.lastMonth:
        return Strings.current.lastMonth;
      case FilterDateTypes.thisYear:
        return Strings.current.thisYear;
      case FilterDateTypes.lastYear:
        return Strings.current.lastYear;
      case FilterDateTypes.custom:
        return Strings.current.custom;
      default:
        return '';
    }
  }
}
