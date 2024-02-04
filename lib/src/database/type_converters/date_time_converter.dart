import 'package:floor/floor.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/extentions/strings.dart';

class DateTimeConverter extends TypeConverter<DateTime, String> {
  @override
  DateTime decode(String databaseValue) {
    return databaseValue.toDateTime();
  }

  @override
  String encode(DateTime value) {
    return value.dbDateTime();
  }
}
