import 'package:floor/floor.dart';

final migration_1 = Migration(1, 2, (database) async {
  //initialize expense types
  List<String> expenseTypes = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Health',
    'Education',
    'Other'
  ];
  for (String expenseType in expenseTypes) {
    int index = expenseTypes.indexOf(expenseType) + 1;
    await database.execute(
        "INSERT INTO expense_types (id, name, description, showOrder) VALUES ($index, '$expenseType', '', $index)");
  }
});
