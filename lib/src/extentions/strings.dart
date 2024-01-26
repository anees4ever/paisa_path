import 'package:intl/intl.dart';

extension StringExt on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  DateTime toDate() {
    return isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(this);
  }

  toDBDate() {
    return isEmpty ? '' : DateFormat('yyyy-MM-dd').format(toDate());
  }

  toDateLocal() {
    return isEmpty
        ? ''
        : DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(this));
  }

  toDateTimeLocal() {
    return isEmpty
        ? ''
        : DateFormat('dd/MM/yyyy hh:mm a')
            .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(this));
  }
}
