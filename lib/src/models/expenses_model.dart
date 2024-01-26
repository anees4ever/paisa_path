import 'package:floor/floor.dart';

//table structure for expenses with expense type, a description, amount, datetime and created and modified timestamps
@Entity(tableName: 'expenses')
class Expenses {
  @PrimaryKey(autoGenerate: true)
  int? id; //should be nullable to allow auto increment
  int expenseTypeId;
  String description;
  double amount;
  DateTime trnDateTime;
  DateTime createdAt;
  DateTime modifiedAt;

  Expenses({
    required this.id,
    required this.expenseTypeId,
    required this.description,
    required this.amount,
    required this.trnDateTime,
    required this.createdAt,
    required this.modifiedAt,
  });

  Expenses.empty()
      : this(
          id: null,
          expenseTypeId: 0,
          description: '',
          amount: 0.0,
          trnDateTime: DateTime.now(),
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
        );

  @override
  String toString() {
    return 'Expenses{id: $id, expenseTypeId: $expenseTypeId, description: $description, amount: $amount, dateTime: $trnDateTime, createdAt: $createdAt, modifiedAt: $modifiedAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Expenses &&
        other.id == id &&
        other.expenseTypeId == expenseTypeId &&
        other.description == description &&
        other.amount == amount &&
        other.trnDateTime == trnDateTime &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        expenseTypeId.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        trnDateTime.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode;
  }
}
