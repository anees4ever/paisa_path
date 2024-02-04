import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/di.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ExpensesController', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await DI.process();
    });

    test('addOrUpdateExpense should add a new expense when expense is null',
        () async {
      // Arrange
      ExpensesController controller = Get.find();
      const amount = 100.0;
      final expenseType =
          ExpenseTypes(id: 1, name: 'Food', description: '', showOrder: 0);
      const description = 'Lunch';
      DateTime datetime = DateTime.now();

      // Act
      final result = await controller.addOrUpdateExpense(
          null, amount, expenseType, description, datetime);

      Expenses? expense = await DI.db.expensesDao.findExpenseById(result);

      // Assert
      expect(expense?.id, result);
      expect(expense?.amount, amount);
      expect(expense?.description, description);
      expect(expense?.expenseTypeId, expenseType.id);
      expect(expense?.trnDateTime, datetime.dbDateTime());
    });

    test(
        'addOrUpdateExpense should update an existing expense when expense is not null',
        () async {
      // Arrange
      ExpensesController controller = Get.find();
      const amount = 100.0;
      final expenseType =
          ExpenseTypes(id: 1, name: 'Food', description: '', showOrder: 0);
      const description = 'Lunch';
      DateTime datetime = DateTime.now();

      final result = await controller.addOrUpdateExpense(
          null, amount, expenseType, description, datetime);

      Expenses? expense = await DI.db.expensesDao.findExpenseById(result);

      const newDescription = 'Dinner';
      const newAmount = 120.0;
      int newResult = await controller.addOrUpdateExpense(
          expense, newAmount, expenseType, newDescription, datetime);

      // Assert
      expect(result, newResult);
      expect(expense?.amount, newAmount);
      expect(expense?.description, newDescription);
      expect(expense?.expenseTypeId, expenseType.id);
      expect(expense?.trnDateTime, datetime.dbDateTime());
    });

    test('deleteExpenseConfirm should delete an expense', () async {
      // Arrange
      ExpensesController controller = Get.find();

      const amount = 100.0;
      final expenseType =
          ExpenseTypes(id: 1, name: 'Food', description: '', showOrder: 0);
      const description = 'Lunch';
      DateTime datetime = DateTime.now();

      final result = await controller.addOrUpdateExpense(
          null, amount, expenseType, description, datetime);

      Expenses? expense = await DI.db.expensesDao.findExpenseById(result);

      expect(expense?.id, result);

      await controller.deleteExpense(expense!);

      Expenses? reReadExpense = await DI.db.expensesDao.findExpenseById(result);

      expect(reReadExpense, null);
    });
  });
}
