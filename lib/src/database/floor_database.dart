import 'package:floor/floor.dart';
import 'package:paisa_path/src/database/dao/expense_types_dao.dart';
import 'package:paisa_path/src/database/dao/expenses_dao.dart';
import 'package:paisa_path/src/database/migrations/migration_1.dart';
import 'package:paisa_path/src/database/type_converters/date_time_converter.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'floor_database.g.dart';

@Database(
  version: 1,
  entities: [
    ExpenseTypes,
    Expenses,
  ],
  views: [],
)
@TypeConverters(
  [
    DateTimeConverter,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  ExpenseTypesDao get expenseTypesDao;
  ExpensesDao get expensesDao;
}

getFloorDatabase() async {
  return await $FloorAppDatabase
      .databaseBuilder('paisa_path_data.db')
      .addCallback(Callback(
    onCreate: (database, version) {
      migration_1.migrate(database);
    },
  )).addMigrations([
    //
  ]).build();
}
