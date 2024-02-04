import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/models/enum_filter_date_types.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/core/theme/colors.dart';

Widget customDropdown({
  required String label,
  required int value,
  required List<DropdownMenuItem<int>> dropdownItems,
  Function(int?)? onChanged,
  String emptyListLabel = 'No data',
}) {
  if (dropdownItems.isEmpty) {
    dropdownItems = [
      dropdownItem(emptyListLabel, 0),
    ];
    value = 0;
  } else {
    //check if value present in dropdownItems, else set to first item
    if (dropdownItems.where((element) => element.value == value).isEmpty) {
      value = dropdownItems[0].value as int;
    }
  }
  return DropdownButtonFormField<int>(
    isExpanded: true,
    decoration: InputDecoration(
      labelText: label,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: inputBorderEnabled.theme, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepOrange, width: 1.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      filled: false,
    ),
    value: value,
    items: dropdownItems,
    onChanged: onChanged,
  );
}

DropdownMenuItem<int> dropdownItem(String label, int value) {
  return DropdownMenuItem<int>(
    value: value,
    child: FittedBox(fit: BoxFit.scaleDown, child: Text(label)),
  );
}

extension ListExtForDropdown<T> on List<T> {
  List<DropdownMenuItem<int>> toDropdownList() {
    if (isEmpty) return [];
    debugPrint('runtimeType: $runtimeType');

    if (runtimeType == List<ExpenseTypes>.empty().runtimeType) {
      return map((e) => dropdownItem((e as ExpenseTypes).name, e.id ?? 0))
          .toList();
    } else if (runtimeType == List<FilterDateTypes>.empty().runtimeType) {
      return map((e) => dropdownItem((e as FilterDateTypes).label, e.index))
          .toList();
    } else {
      return [];
    }
  }
}

extension RxListExtForDropdown<T> on RxList<T> {
  List<DropdownMenuItem<int>> toDropdownList() {
    if (isEmpty) return [];
    debugPrint('runtimeType: $runtimeType');

    if (runtimeType == RxList<ExpenseTypes>.empty().runtimeType) {
      return map((e) => dropdownItem((e as ExpenseTypes).name, e.id ?? 0))
          .toList();
    } else if (runtimeType == RxList<FilterDateTypes>.empty().runtimeType) {
      return map((e) => dropdownItem((e as FilterDateTypes).label, e.index))
          .toList();
    } else {
      return [];
    }
  }
}
