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
  String query =
      'INSERT INTO expense_types (id, name, description, showOrder) VALUES ';
  for (String expenseType in expenseTypes) {
    int index = expenseTypes.indexOf(expenseType) + 1;
    query += '($index, "$expenseType", "", $index),';
  }
  query = query.substring(0, query.length - 1);
  await database.execute(query);
});
