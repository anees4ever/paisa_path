import 'package:floor/floor.dart';

enum ItemType {
  goods(0),
  special(1);

  const ItemType(this.value);
  final int value;

  static ItemType fromValue(int value) {
    switch (value) {
      case 1:
        return ItemType.special;
      case 0:
      default:
        return ItemType.goods;
    }
  }
}

@Entity(tableName: 'items_master')
class Items {
  @PrimaryKey(autoGenerate: true)
  int? id; //should be nullable to allow auto increment
  String name;
  String description;
  int itemParent;
  double price;
  ItemType? itemType;
  bool hasChildren;
  int showOrder;
  double openingStock;
  double currentStock;
  double currentStockLess;
  double currentDeductions;

  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.itemParent,
    required this.price,
    required this.itemType,
    required this.hasChildren,
    required this.showOrder,
    required this.openingStock,
    required this.currentStock,
    required this.currentStockLess,
    required this.currentDeductions,
  });

  Items.empty()
      : this(
          id: null,
          name: '',
          description: '',
          itemParent: 0,
          price: 0,
          itemType: ItemType.goods,
          hasChildren: false,
          showOrder: 0,
          openingStock: 0,
          currentStock: 0,
          currentStockLess: 0,
          currentDeductions: 0,
        );

  @override
  String toString() {
    return 'Items{id: $id, name: $name, description: $description, itemParent: $itemParent, price: $price, itemType: $itemType, hasChildren: $hasChildren, showOrder: $showOrder, openingStock: $openingStock, currentStock: $currentStock, currentStockLess: $currentStockLess, currentDeductions: $currentDeductions }';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Items &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.itemParent == itemParent &&
        other.price == price &&
        other.itemType == itemType &&
        other.hasChildren == hasChildren &&
        other.showOrder == showOrder &&
        other.openingStock == openingStock &&
        other.currentStock == currentStock &&
        other.currentStockLess == currentStockLess &&
        other.currentDeductions == currentDeductions;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        itemParent.hashCode ^
        price.hashCode ^
        itemType.hashCode ^
        hasChildren.hashCode ^
        showOrder.hashCode ^
        openingStock.hashCode ^
        currentStock.hashCode ^
        currentStockLess.hashCode ^
        currentDeductions.hashCode;
  }
}
