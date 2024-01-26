import 'package:floor/floor.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';

//dao for expense types
@dao
abstract class ExpenseTypesDao {
  @Query('SELECT * FROM expense_types ORDER BY showOrder ASC')
  Future<List<ExpenseTypes>> listExpenseTypes();

  @Query('SELECT * FROM expense_types WHERE id = :id')
  Future<ExpenseTypes?> findExpenseTypeById(int id);

  @insert
  Future<void> insertExpenseType(ExpenseTypes expenseType);

  @update
  Future<void> updateExpenseType(ExpenseTypes expenseType);

  @delete
  Future<void> deleteExpenseType(ExpenseTypes expenseType);
}
