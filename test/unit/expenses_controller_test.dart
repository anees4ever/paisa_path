import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/di.dart';
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
      ExpensesController controller = Get.find()..expensesFiltered.clear();
      const amount = 100.0;
      final expenseType =
          ExpenseTypes(id: 1, name: 'Food', description: '', showOrder: 0);
      const description = 'Lunch';

      // Act
      final result = await controller.addOrUpdateExpense(
          null, amount, expenseType, description);

      // Assert
      expect(result, true);
      expect(controller.expensesFiltered.length, 1);
      expect(controller.expensesFiltered[0].amount, amount);
      expect(controller.expensesFiltered[0].description, description);
      expect(controller.expensesFiltered[0].expenseTypeId, expenseType.id);
    });

    test(
        'addOrUpdateExpense should update an existing expense when expense is not null',
        () async {
      // Arrange
      ExpensesController controller = Get.find()..expensesFiltered.clear();
      final existingExpense = Expenses(
        id: 1,
        amount: 50.0,
        description: 'Dinner',
        expenseTypeId: 2,
        trnDateTime: DateTime.now(),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      controller.expensesFiltered.add(existingExpense);
      const amount = 75.0;
      final expenseType =
          ExpenseTypes(id: 3, name: 'Transport', description: '', showOrder: 0);
      const description = 'Taxi fare';

      // Act
      final result = await controller.addOrUpdateExpense(
          existingExpense, amount, expenseType, description);

      // Assert
      expect(result, true);
      expect(controller.expensesFiltered.length, 1);
      expect(controller.expensesFiltered[0].id, existingExpense.id);
      expect(controller.expensesFiltered[0].amount, amount);
      expect(controller.expensesFiltered[0].description, description);
      expect(controller.expensesFiltered[0].expenseTypeId, expenseType.id);
    });

    test('deleteExpenseConfirm should delete an expense', () async {
      // Arrange
      ExpensesController controller = Get.find()..expensesFiltered.clear();

      final expense = Expenses(
        id: 1,
        amount: 50.0,
        description: 'Dinner',
        expenseTypeId: 2,
        trnDateTime: DateTime.now(),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      controller.expensesFiltered.add(expense);

      // Act
      await controller.deleteExpense(expense);

      // Assert
      expect(controller.expensesFiltered.length, 0);
    });
  });
}
