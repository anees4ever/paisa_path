import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(String format) {
    assert(format.isNotEmpty);
    return DateFormat(format).format(this);
  }

  String formatLocal() {
    return format('dd/MM/yyyy');
  }

  String dbDate() {
    return format('yyyy-MM-dd');
  }

  String dbDateTime() {
    return format('yyyy-MM-dd HH:mm:ss');
  }

  String dbTime() {
    return format('HH:mm:ss');
  }

  String formatDateTime() {
    return format('dd/MM/yy hh:mm a');
  }

  bool sameDate(DateTime? other) {
    other ??= DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }

  String formattedDate() {
    return format('dd/MM/yyyy');
  }

  String formattedTime() {
    return format('hh:mm a');
  }
}
