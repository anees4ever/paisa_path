// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpenseTypesDao? _expenseTypesDaoInstance;

  ExpensesDao? _expensesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expense_types` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `showOrder` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expenses` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `expenseTypeId` INTEGER NOT NULL, `description` TEXT NOT NULL, `amount` REAL NOT NULL, `trnDateTime` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `modifiedAt` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpenseTypesDao get expenseTypesDao {
    return _expenseTypesDaoInstance ??=
        _$ExpenseTypesDao(database, changeListener);
  }

  @override
  ExpensesDao get expensesDao {
    return _expensesDaoInstance ??= _$ExpensesDao(database, changeListener);
  }
}

class _$ExpenseTypesDao extends ExpenseTypesDao {
  _$ExpenseTypesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _expenseTypesInsertionAdapter = InsertionAdapter(
            database,
            'expense_types',
            (ExpenseTypes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'showOrder': item.showOrder
                }),
        _expenseTypesUpdateAdapter = UpdateAdapter(
            database,
            'expense_types',
            ['id'],
            (ExpenseTypes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'showOrder': item.showOrder
                }),
        _expenseTypesDeletionAdapter = DeletionAdapter(
            database,
            'expense_types',
            ['id'],
            (ExpenseTypes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'showOrder': item.showOrder
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExpenseTypes> _expenseTypesInsertionAdapter;

  final UpdateAdapter<ExpenseTypes> _expenseTypesUpdateAdapter;

  final DeletionAdapter<ExpenseTypes> _expenseTypesDeletionAdapter;

  @override
  Future<List<ExpenseTypes>> listExpenseTypes() async {
    return _queryAdapter.queryList(
        'SELECT * FROM expense_types ORDER BY showOrder ASC',
        mapper: (Map<String, Object?> row) => ExpenseTypes(
            id: row['id'] as int?,
            name: row['name'] as String,
            description: row['description'] as String,
            showOrder: row['showOrder'] as int));
  }

  @override
  Future<ExpenseTypes?> findExpenseTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM expense_types WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ExpenseTypes(
            id: row['id'] as int?,
            name: row['name'] as String,
            description: row['description'] as String,
            showOrder: row['showOrder'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertExpenseType(ExpenseTypes expenseType) async {
    await _expenseTypesInsertionAdapter.insert(
        expenseType, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateExpenseType(ExpenseTypes expenseType) async {
    await _expenseTypesUpdateAdapter.update(
        expenseType, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteExpenseType(ExpenseTypes expenseType) async {
    await _expenseTypesDeletionAdapter.delete(expenseType);
  }
}

class _$ExpensesDao extends ExpensesDao {
  _$ExpensesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _expensesInsertionAdapter = InsertionAdapter(
            database,
            'expenses',
            (Expenses item) => <String, Object?>{
                  'id': item.id,
                  'expenseTypeId': item.expenseTypeId,
                  'description': item.description,
                  'amount': item.amount,
                  'trnDateTime': item.trnDateTime,
                  'createdAt': item.createdAt,
                  'modifiedAt': item.modifiedAt
                }),
        _expensesUpdateAdapter = UpdateAdapter(
            database,
            'expenses',
            ['id'],
            (Expenses item) => <String, Object?>{
                  'id': item.id,
                  'expenseTypeId': item.expenseTypeId,
                  'description': item.description,
                  'amount': item.amount,
                  'trnDateTime': item.trnDateTime,
                  'createdAt': item.createdAt,
                  'modifiedAt': item.modifiedAt
                }),
        _expensesDeletionAdapter = DeletionAdapter(
            database,
            'expenses',
            ['id'],
            (Expenses item) => <String, Object?>{
                  'id': item.id,
                  'expenseTypeId': item.expenseTypeId,
                  'description': item.description,
                  'amount': item.amount,
                  'trnDateTime': item.trnDateTime,
                  'createdAt': item.createdAt,
                  'modifiedAt': item.modifiedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Expenses> _expensesInsertionAdapter;

  final UpdateAdapter<Expenses> _expensesUpdateAdapter;

  final DeletionAdapter<Expenses> _expensesDeletionAdapter;

  @override
  Future<List<Expenses>> listExpenses() async {
    return _queryAdapter.queryList(
        'SELECT * FROM expenses ORDER BY trnDateTime DESC',
        mapper: (Map<String, Object?> row) => Expenses(
            id: row['id'] as int?,
            expenseTypeId: row['expenseTypeId'] as int,
            description: row['description'] as String,
            amount: row['amount'] as double,
            trnDateTime: row['trnDateTime'] as String,
            createdAt: row['createdAt'] as String,
            modifiedAt: row['modifiedAt'] as String));
  }

  @override
  Future<List<Expenses>> listExpensesInPeriod(
    String fromDate,
    String toDate,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM expenses WHERE DATE(trnDateTime) BETWEEN ?1 AND ?2 ORDER BY trnDateTime DESC',
        mapper: (Map<String, Object?> row) => Expenses(id: row['id'] as int?, expenseTypeId: row['expenseTypeId'] as int, description: row['description'] as String, amount: row['amount'] as double, trnDateTime: row['trnDateTime'] as String, createdAt: row['createdAt'] as String, modifiedAt: row['modifiedAt'] as String),
        arguments: [fromDate, toDate]);
  }

  @override
  Future<Expenses?> findExpenseById(int id) async {
    return _queryAdapter.query('SELECT * FROM expenses WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Expenses(
            id: row['id'] as int?,
            expenseTypeId: row['expenseTypeId'] as int,
            description: row['description'] as String,
            amount: row['amount'] as double,
            trnDateTime: row['trnDateTime'] as String,
            createdAt: row['createdAt'] as String,
            modifiedAt: row['modifiedAt'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertExpense(Expenses expense) {
    return _expensesInsertionAdapter.insertAndReturnId(
        expense, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateExpense(Expenses expense) async {
    await _expensesUpdateAdapter.update(expense, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteExpense(Expenses expense) async {
    await _expensesDeletionAdapter.delete(expense);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
