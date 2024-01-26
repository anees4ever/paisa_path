import 'package:get/get.dart';
import 'package:paisa_path/src/di.dart';
import 'package:paisa_path/src/extentions/datetime.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/models/expenses_model.dart';

class ExpensesController extends GetxController {
  RxList<ExpenseTypes> expenseTypes = RxList([]);
  RxList<Expenses> expensesFiltered = RxList([]);
  RxList<Expenses> expensesToday = RxList([]);

  @override
  void onInit() async {
    super.onInit();

    loadExpenseTypes();
    loadExpenses();
  }

  loadExpenseTypes() async {
    expenseTypes.value = await DI.db.expenseTypesDao.listExpenseTypes();
  }

  loadExpenses() async {
    expensesFiltered.value = await DI.db.expensesDao.listExpenses();
    expensesToday.value = expensesFiltered.where((e) {
      return e.trnDateTime.sameDate(null);
    }).toList();
  }

  addOrUpdateExpense(Expenses? expense, double amount, ExpenseTypes expenseType,
      String description) async {
    if (expense == null) {
      Expenses newExpense = Expenses(
        id: null,
        amount: amount,
        description: description,
        expenseTypeId: expenseType.id ?? 0,
        trnDateTime: DateTime.now(),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      newExpense.id = await DI.db.expensesDao.insertExpense(newExpense);
      //insert new record into the list instead of refreshing the list
      expensesFiltered.insert(0, newExpense);
      if (newExpense.trnDateTime.sameDate(null)) {
        expensesToday.insert(0, newExpense);
      }
    } else {
      expense.amount = amount;
      expense.description = description;
      expense.expenseTypeId = expenseType.id ?? 0;
      expense.modifiedAt = DateTime.now();
      await DI.db.expensesDao.updateExpense(expense);
      //update the list instead of refreshing the list
      expensesFiltered[expensesFiltered
          .indexWhere((element) => element.id == expense.id)] = expense;
      if (expense.trnDateTime.sameDate(null)) {
        expensesToday[expensesToday
            .indexWhere((element) => element.id == expense.id)] = expense;
      }
    }

    return true;
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
    expensesFiltered.removeWhere((element) => element.id == expense.id);
    expensesToday.removeWhere((element) => element.id == expense.id);
  }

  ExpenseTypes getExpenseTypeById(int id) {
    return expenseTypes.firstWhere((element) => element.id == id, orElse: () {
      return ExpenseTypes.empty();
    });
  }
}
