import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/extentions/datetime.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/expense_types_model.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:paisa_path/src/screens/custom_widgets/textfield.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/theme/styles.dart';

class ExpenseEntryScreen extends StatefulWidget {
  final Expenses? expense;
  const ExpenseEntryScreen({super.key, this.expense});
  @override
  State<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();

  static Future<void> show(Expenses? expense) async {
    return await showModalBottomSheet(
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
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ExpensesController expensesController = Get.find();

  ExpenseTypes expenseType = ExpenseTypes.empty();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      expenseType =
          expensesController.getExpenseTypeById(widget.expense!.expenseTypeId);
      typeController.text = expenseType.id == null
          ? Strings.current.notSelected
          : expenseType.name;
      amountController.text = widget.expense!.amount.roundIf();
      descriptionController.text = widget.expense!.description;
    }
  }

  @override
  void dispose() {
    typeController.dispose();
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
                child: EditBox(
                  controller: typeController,
                  readOnly: true,
                  textAlign: TextAlign.start,
                  labelText: Strings.current.type,
                  suffixIcon: Icons.arrow_drop_down,
                ),
              ),
            ],
          ),

          //show the date in a text and an edit button next to it
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.expense == null
                      ? DateTime.now().formatDateTime()
                      : widget.expense!.trnDateTime.formatDateTime(),
                  textAlign: TextAlign.end,
                  style: textStyleContent,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: appBarColorLight),
                onPressed: () {},
              ),
            ],
          ),

          //save button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //getElevatedButton
              getElevatedButton(
                title: widget.expense == null
                    ? Strings.current.save
                    : Strings.current.update,
                icon: const Icon(Icons.save),
                onPressed: () => _saveExpense(),
                width: 160,
                height: 40,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _saveExpense() async {
    bool result = await expensesController.addOrUpdateExpense(
        widget.expense,
        double.tryParse(amountController.text) ?? 0,
        expenseType,
        descriptionController.text);
    if (result) {
      Get.back();
    }
  }
}
