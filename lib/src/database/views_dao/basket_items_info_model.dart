import 'package:floor/floor.dart';

@DatabaseView(
    ' select bi.id, bi.itemId, bi.basketId, bi.rate, bi.itemQty, bi.containerQty, '
    ' bi.deductionQty, bi.containerCount, im.name from temp_basket_items bi  '
    ' inner join items_master im on bi.itemId = im.id  ',
    viewName: 'basket_items_info')
class BasketItemsInfo {
  final int? id;
  final int itemId;
  final int basketId;
  final double rate;
  final double itemQty;
  final double containerQty;
  final double deductionQty;
  final double containerCount;
  final String? name;

  BasketItemsInfo(this.id, this.itemId, this.basketId, this.rate, this.itemQty,
      this.containerQty, this.deductionQty, this.containerCount, this.name);
}
