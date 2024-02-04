import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/core/extentions/strings.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:paisa_path/src/screens/custom_widgets/custom_dropdown.dart';
import 'package:paisa_path/src/screens/custom_widgets/date_picker.dart';
import 'package:paisa_path/src/screens/custom_widgets/textfield.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';

class ExpenseEntryScreen extends StatefulWidget {
  final Expenses? expense;
  const ExpenseEntryScreen({super.key, this.expense});
  @override
  State<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();

  static Future<bool?> show(Expenses? expense) async {
    return await showModalBottomSheet<bool>(
        context: Get.context!,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (context) {
          double paddingBottom = MediaQuery.of(context).viewInsets.bottom;
          return Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ExpenseEntryScreen(expense: expense),
              ),
            ),
          );
        });
  }
}

class _ExpenseEntryScreenState extends State<ExpenseEntryScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController trnDateController = TextEditingController();
  final ExpensesController expensesController = Get.find();

  @override
  void initState() {
    super.initState();
    expensesController.entryError('');
    expensesController.entryExpenseType.value =
        widget.expense?.expenseTypeId ?? 0;
    trnDateController.text = DateTime.now().formatLocal();
    if (widget.expense != null) {
      amountController.text = widget.expense!.amount.roundIf();
      descriptionController.text = widget.expense!.description;
      trnDateController.text = widget.expense!.trnDateTime.toDateLocal();
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_rounded,
                size: 28,
                color: Colors.blueAccent,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.current.expenseEntry,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              //close button
              IconButton(
                icon: const Icon(Icons.close, color: appBarColorLight),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: EditBox(
                  controller: descriptionController,
                  selectAllOnFocus: true,
                  autofocus: true,
                  labelText: Strings.current.description,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: EditBox(
                  controller: amountController,
                  selectAllOnFocus: true,
                  textAlign: TextAlign.end,
                  labelText: Strings.current.amount,
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: customDropdown(
                  label: Strings.current.expenseType,
                  value: expensesController.entryExpenseType.value,
                  onChanged: (int? value) {
                    expensesController.entryExpenseType(value ?? 0);
                  },
                  dropdownItems: [
                    dropdownItem(Strings.current.notSelected, 0),
                    ...expensesController.expenseTypes.toDropdownList(),
                  ],
                ),
              ),
            ],
          ),

          //save button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: DatePicker(
                  label: Strings.current.from,
                  controller: trnDateController,
                ),
              ),
              Expanded(
                child: getElevatedButton(
                  title: widget.expense == null
                      ? Strings.current.save
                      : Strings.current.update,
                  icon: const Icon(Icons.save),
                  onPressed: () => _saveExpense(),
                  width: 160,
                  height: 40,
                ),
              ),
            ],
          ),

          GetX<ExpensesController>(builder: (controller) {
            if (controller.entryError.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.entryError.value,
                style: textStyleError.copyWith(
                  color: fontColorError.theme,
                ),
              ),
            );
          }),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _saveExpense() async {
    int result = await expensesController.addOrUpdateExpense(
        widget.expense,
        double.tryParse(amountController.text) ?? 0,
        expensesController.entryExpenseTypeValue,
        descriptionController.text,
        trnDateController.text.toDate());
    if (result > 0) {
      Get.back(result: true);
    }
  }
}
