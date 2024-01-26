import 'package:floor/floor.dart';
import 'package:paisa_path/src/database/dao/items_model.dart';

@dao
abstract class ItemsDao {
  @Query(
      'SELECT * FROM items_master WHERE itemType = :type ORDER BY showOrder ASC')
  Future<List<Items>> findItems(int type);

  @Query('SELECT * FROM items_master ORDER BY showOrder ASC')
  Future<List<Items>> listItems();

  @Query('SELECT * FROM items_master WHERE id = :id')
  Future<Items?> findItemById(int id);

  @insert
  Future<void> insertItem(Items item);

  @update
  Future<void> updateItem(Items item);

  @delete
  Future<void> deleteItem(Items item);

  //increase the stock
  @Query(
      'UPDATE items_master SET currentStock = currentStock + :stock, currentStockLess= currentStockLess + :stockLess, '
      'currentDeductions= currentDeductions + :deductions  WHERE id = :id')
  Future<void> increaseStock(
      int id, double stock, double stockLess, double deductions);

  //decrease the stock
  @Query(
      'UPDATE items_master SET currentStock = currentStock - :stock, currentStockLess= currentStockLess - :stockLess, '
      'currentDeductions= currentDeductions - :deductions WHERE id = :id')
  Future<void> decreaseStock(
      int id, double stock, double stockLess, double deductions);
}
