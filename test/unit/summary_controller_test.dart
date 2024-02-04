import 'package:flutter_test/flutter_test.dart';
import 'package:paisa_path/src/controllers/summary_controller.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/models/enum_filter_date_types.dart';

void main() {
  group('SummaryController', () {
    test('updateFromToDates should update fromDate and toDate correctly', () {
      SummaryController controller = SummaryController();
      DateTime now = DateTime.now();

      controller.filterType.value = FilterDateTypes.today;
      controller.updateFromToDates();
      DateTime fromDateToday = controller.fromDate.value;
      DateTime toDateToday = controller.toDate.value;

      expect(fromDateToday.formattedDate(),
          DateTime(now.year, now.month, now.day).formattedDate());
      expect(toDateToday.formattedDate(),
          DateTime(now.year, now.month, now.day).formattedDate());

      controller.filterType.value = FilterDateTypes.yesterday;
      controller.updateFromToDates();
      DateTime fromDateYesterday = controller.fromDate.value;
      DateTime toDateYesterday = controller.toDate.value;

      expect(fromDateYesterday.formattedDate(),
          DateTime(now.year, now.month, now.day - 1).formattedDate());
      expect(toDateYesterday.formattedDate(),
          DateTime(now.year, now.month, now.day - 1).formattedDate());

      controller.filterType.value = FilterDateTypes.thisWeek;
      controller.updateFromToDates();
      DateTime fromDateThisWeek = controller.fromDate.value;
      DateTime toDateThisWeek = controller.toDate.value;

      expect(fromDateThisWeek.formattedDate(),
          DateTime(now.year, now.month, now.day - now.weekday).formattedDate());
      expect(toDateThisWeek.formattedDate(),
          DateTime(now.year, now.month, now.day).formattedDate());

      controller.filterType.value = FilterDateTypes.lastWeek;
      controller.updateFromToDates();
      DateTime fromDateLastWeek = controller.fromDate.value;
      DateTime toDateLastWeek = controller.toDate.value;

      expect(
          fromDateLastWeek.formattedDate(),
          DateTime(now.year, now.month, now.day - now.weekday - 7)
              .formattedDate());
      expect(toDateLastWeek.formattedDate(),
          DateTime(now.year, now.month, now.day - now.weekday).formattedDate());

      controller.filterType.value = FilterDateTypes.thisMonth;
      controller.updateFromToDates();
      DateTime fromDateThisMonth = controller.fromDate.value;
      DateTime toDateThisMonth = controller.toDate.value;

      expect(fromDateThisMonth.formattedDate(),
          DateTime(now.year, now.month, 1).formattedDate());
      expect(toDateThisMonth.formattedDate(),
          DateTime(now.year, now.month, now.day).formattedDate());

      controller.filterType.value = FilterDateTypes.lastMonth;
      controller.updateFromToDates();
      DateTime fromDateLastMonth = controller.fromDate.value;
      DateTime toDateLastMonth = controller.toDate.value;

      expect(fromDateLastMonth.formattedDate(),
          DateTime(now.year, now.month - 1, 1).formattedDate());
      expect(toDateLastMonth.formattedDate(),
          DateTime(now.year, now.month, 0).formattedDate());

      controller.filterType.value = FilterDateTypes.thisYear;
      controller.updateFromToDates();
      DateTime fromDateThisYear = controller.fromDate.value;
      DateTime toDateThisYear = controller.toDate.value;

      expect(fromDateThisYear.formattedDate(),
          DateTime(now.year, 1, 1).formattedDate());
      expect(toDateThisYear.formattedDate(),
          DateTime(now.year, now.month, now.day).formattedDate());

      controller.filterType.value = FilterDateTypes.lastYear;
      controller.updateFromToDates();
      DateTime fromDateLastYear = controller.fromDate.value;
      DateTime toDateLastYear = controller.toDate.value;

      expect(fromDateLastYear.formattedDate(),
          DateTime(now.year - 1, 1, 1).formattedDate());
      expect(toDateLastYear.formattedDate(),
          DateTime(now.year - 1, 12, 31).formattedDate());
    });
  });
}
