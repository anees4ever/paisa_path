import 'package:floor/floor.dart';

//table structure for expense types
@Entity(tableName: 'expense_types')
class ExpenseTypes {
  @PrimaryKey(autoGenerate: true)
  int? id; //should be nullable to allow auto increment
  String name;
  String description;
  int showOrder;

  ExpenseTypes({
    required this.id,
    required this.name,
    required this.description,
    required this.showOrder,
  });

  ExpenseTypes.empty()
      : this(
          id: null,
          name: '',
          description: '',
          showOrder: 0,
        );

  @override
  String toString() {
    return 'ExpenseTypes{id: $id, name: $name, description: $description, showOrder: $showOrder}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseTypes &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.showOrder == showOrder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        showOrder.hashCode;
  }
}
