import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/di.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/enum_filter_date_types.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
import 'package:paisa_path/src/models/summary_item.dart';

class SummaryController extends GetxController {
  final RxList<SummaryItem> _summaryItems = RxList([]);
  List<SummaryItem> get summaryItems => _summaryItems.toList();
  final RxDouble _totalAmount = RxDouble(0);
  double get totalAmount => _totalAmount.value;

  //Filter Specific
  Rx<FilterDateTypes> filterType = Rx<FilterDateTypes>(FilterDateTypes.today);
  Rx<DateTime> fromDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> toDate = Rx<DateTime>(DateTime.now());

  generateSummary() async {
    List<ExpenseTypes> expenseTypes =
        Get.find<ExpensesController>().expenseTypes;
    List<Expenses> expenses = await DI.db.expensesDao.listExpenses();
    List<SummaryItem> items = [];
    _totalAmount.value = 0;
    double total = 0;

    for (var expense in expenses) {
      total += expense.amount;

      SummaryItem? item = items.firstWhereOrNull(
        (element) => element.typeId == expense.expenseTypeId,
      );

      if (item == null) {
        ExpenseTypes? type = expenseTypes
            .firstWhereOrNull((element) => element.id == expense.expenseTypeId);
        items.add(SummaryItem(
          typeId: type == null ? 0 : expense.expenseTypeId,
          typeName: type == null ? Strings.current.uncategorized : type.name,
          amount: expense.amount,
        ));
      } else {
        item.amount += expense.amount;
      }
    }

    _totalAmount.value = total;
    _summaryItems.value = items;
  }

  showDateFilter(Function(FilterDateTypes) callback) {
    Get.defaultDialog(
      title: Strings.current.filter,
      content: Column(
        children: FilterDateTypes.values
            .map(
              (e) => ListTile(
                title: Text(e.label),
                onTap: () {
                  Get.back();
                  filterType.value = e;
                  _updateFromToDates();
                  callback(e);
                  generateSummary();
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _updateFromToDates() {
    DateTime now = DateTime.now();
    switch (filterType.value) {
      case FilterDateTypes.today:
        fromDate.value = DateTime(now.year, now.month, now.day);
        toDate.value = DateTime(now.year, now.month, now.day);
        break;
      case FilterDateTypes.yesterday:
        fromDate.value = DateTime(now.year, now.month, now.day - 1);
        toDate.value = DateTime(now.year, now.month, now.day - 1);
        break;
      case FilterDateTypes.thisWeek:
        fromDate.value = DateTime(now.year, now.month, now.day - now.weekday);
        toDate.value = DateTime(now.year, now.month, now.day);
        break;
      case FilterDateTypes.lastWeek:
        fromDate.value =
            DateTime(now.year, now.month, now.day - now.weekday - 7);
        toDate.value = DateTime(now.year, now.month, now.day - now.weekday);
        break;
      case FilterDateTypes.thisMonth:
        fromDate.value = DateTime(now.year, now.month, 1);
        toDate.value = DateTime(now.year, now.month + 1, 0);
        break;
      case FilterDateTypes.lastMonth:
        fromDate.value = DateTime(now.year, now.month - 1, 1);
        toDate.value = DateTime(now.year, now.month, 0);
        break;
      case FilterDateTypes.thisYear:
        fromDate.value = DateTime(now.year, 1, 1);
        toDate.value = DateTime(now.year, 12, 31);
        break;
      case FilterDateTypes.lastYear:
        fromDate.value = DateTime(now.year - 1, 1, 1);
        toDate.value = DateTime(now.year - 1, 12, 31);
        break;
      default:
        fromDate.value = DateTime(now.year, now.month, now.day);
        toDate.value = DateTime(now.year, now.month, now.day);
        break;
    }
  }
}
