import 'package:get/get.dart';
import 'package:paisa_path/di.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/models/expenses_model.dart';

class ExpensesController extends GetxController {
  RxList<ExpenseTypes> expenseTypes = RxList([]);
  RxList<Expenses> expensesInAPeriod = RxList([]);
  RxList<Expenses> expensesToday = RxList([]);

  Rx<DateTime> filterFromDate =
      Rx<DateTime>(DateTime.now().subtract(const Duration(days: 7)));
  Rx<DateTime> filterToDate = Rx<DateTime>(DateTime.now());
  RxList<ExpenseTypes> selectedExpenseTypes = RxList([]);

  RxInt entryExpenseType = RxInt(0);
  ExpenseTypes get entryExpenseTypeValue =>
      expenseTypes.firstWhere((element) => element.id == entryExpenseType.value,
          orElse: () => ExpenseTypes.empty());

  RxString entryError = RxString('');

  RxDouble expenseTotalToday = RxDouble(0.0);
  RxDouble expenseTotalThisWeek = RxDouble(0.0);
  RxDouble expenseTotalThisMonth = RxDouble(0.0);

  List<Expenses> get expensesInAPeriodFiltered {
    if (selectedExpenseTypes.isEmpty) {
      return expensesInAPeriod;
    } else {
      return expensesInAPeriod
          .where((element) => selectedExpenseTypes.contains(expenseTypes
              .firstWhere((type) => type.id == element.expenseTypeId,
                  orElse: () => ExpenseTypes.empty())))
          .toList();
    }
  }

  double get getFilteredTotal =>
      expensesInAPeriodFiltered.fold(0.0, (previousValue, element) {
        return previousValue + element.amount;
      });

  @override
  void onInit() async {
    super.onInit();

    loadExpenseTypes();
    loadExpenses();
  }

  addSelectedExpenseType(ExpenseTypes expenseType) {
    if (selectedExpenseTypes.contains(expenseType)) {
      selectedExpenseTypes.remove(expenseType);
    } else {
      selectedExpenseTypes.add(expenseType);
    }
  }

  removeSelectedExpenseType(ExpenseTypes expenseType) {
    selectedExpenseTypes.remove(expenseType);
  }

  loadExpenseTypes() async {
    expenseTypes.value = await DI.db.expenseTypesDao.listExpenseTypes();
  }

  loadExpenses() async {
    expensesInAPeriod.value = await DI.db.expensesDao.listExpensesInPeriod(
        filterFromDate.value.dbDate(), filterToDate.value.dbDate());
    expensesToday.value = await DI.db.expensesDao
        .listExpensesInPeriod(DateTime.now().dbDate(), DateTime.now().dbDate());

    expenseTotalToday.value = expensesToday.fold(0.0, (previousValue, element) {
      return previousValue + element.amount;
    });
    List<Expenses> expensesThisWeek = await DI.db.expensesDao
        .listExpensesInPeriod(
            DateTime.now().subtract(const Duration(days: 7)).dbDate(),
            DateTime.now().dbDate());
    expenseTotalThisWeek.value =
        expensesThisWeek.fold(0.0, (previousValue, element) {
      return previousValue + element.amount;
    });
    List<Expenses> expensesThisMonth = await DI.db.expensesDao
        .listExpensesInPeriod(
            DateTime(DateTime.now().year, DateTime.now().month, 1).dbDate(),
            DateTime.now().dbDate());
    expenseTotalThisMonth.value =
        expensesThisMonth.fold(0.0, (previousValue, element) {
      return previousValue + element.amount;
    });
  }

  Future<int> addOrUpdateExpense(Expenses? expense, double amount,
      ExpenseTypes expenseType, String description, DateTime trnDate) async {
    entryError('');

    if (amount <= 0) {
      entryError(Strings.current.amountIsRequired);
      return 0;
    }

    if (expense == null) {
      Expenses newExpense = Expenses(
        id: null,
        amount: amount,
        description: description,
        expenseTypeId: expenseType.id ?? 0,
        trnDateTime: trnDate.dbDateTime(),
        createdAt: DateTime.now().dbDateTime(),
        modifiedAt: DateTime.now().dbDateTime(),
      );
      newExpense.id = await DI.db.expensesDao.insertExpense(newExpense);

      loadExpenses();
      return newExpense.id ?? 0;
    } else {
      expense.amount = amount;
      expense.description = description;
      expense.expenseTypeId = expenseType.id ?? 0;
      expense.trnDateTime = trnDate.dbDateTime();
      expense.modifiedAt = DateTime.now().dbDateTime();
      await DI.db.expensesDao.updateExpense(expense);

      loadExpenses();
      return expense.id ?? 0;
    }
  }

  deleteExpenseConfirm(Expenses expense) {
    Get.defaultDialog(
      title: Strings.current.deleteExpense,
      middleText: Strings.current.deleteExpenseMessage
          .withParam('${expense.description}, ${expense.amount.amount()}'),
      textConfirm: Strings.current.delete,
      textCancel: Strings.current.cancel,
      onConfirm: () async {
        await deleteExpense(expense);
        Get.back();
      },
    );
  }

  deleteExpense(Expenses expense) async {
    await DI.db.expensesDao.deleteExpense(expense);
    loadExpenses();
  }

  ExpenseTypes getExpenseTypeById(int id) {
    return expenseTypes.firstWhere((element) => element.id == id, orElse: () {
      return ExpenseTypes.empty();
    });
  }
}
