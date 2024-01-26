import 'package:floor/floor.dart';
import 'package:paisa_path/src/models/expenses_model.dart';

//dao for expenses
@dao
abstract class ExpensesDao {
  @Query('SELECT * FROM expenses ORDER BY trnDateTime DESC')
  Future<List<Expenses>> listExpenses();

  @Query('SELECT * FROM expenses WHERE id = :id')
  Future<Expenses?> findExpenseById(int id);

  @insert
  Future<int> insertExpense(Expenses expense);

  @update
  Future<void> updateExpense(Expenses expense);

  @delete
  Future<void> deleteExpense(Expenses expense);
}
