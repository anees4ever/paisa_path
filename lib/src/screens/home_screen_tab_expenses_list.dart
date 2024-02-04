import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/core/extentions/strings.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/expenses_model.dart';
import 'package:paisa_path/src/screens/custom_widgets/date_picker.dart';
import 'package:paisa_path/src/screens/expense_entry_screen.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';

class ExpensesListScreen extends StatelessWidget {
  const ExpensesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();

    return Column(
      children: [
        GetX<ExpensesController>(builder: (expenseController) {
          return Row(
            children: [
              Expanded(
                child: DatePicker(
                  label: Strings.current.from,
                  controller: fromDateController,
                  initialDate: expenseController.filterFromDate.value,
                  onSelected: (p0) {
                    expenseController.filterFromDate(p0);
                    expenseController.loadExpenses();
                  },
                ),
              ),
              Expanded(
                child: DatePicker(
                  label: Strings.current.to,
                  controller: toDateController,
                  initialDate: expenseController.filterToDate.value,
                  onSelected: (p0) {
                    expenseController.filterToDate(p0);
                    expenseController.loadExpenses();
                  },
                ),
              ),
            ],
          );
        }),
        GetX<ExpensesController>(builder: (expenseController) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: expenseController.expenseTypes.map((type) {
                bool isSelected =
                    expenseController.selectedExpenseTypes.contains(type);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(type.name),
                    selected: isSelected,
                    selectedColor: appBarColorLight,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? fontColorDark : fontColor.theme,
                    ),
                    onSelected: (bool selected) {
                      if (selected) {
                        expenseController.addSelectedExpenseType(type);
                      } else {
                        expenseController.removeSelectedExpenseType(type);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          );
        }),
        const Divider(),
        Expanded(
          child: GetX<ExpensesController>(
            builder: (controller) {
              if (controller.expensesInAPeriodFiltered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.money_off,
                        size: 48,
                        color: appBarColorLight,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Strings.current.noExpenses,
                        style: textStyleSubtitle,
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                itemCount: controller.expensesInAPeriodFiltered.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  Expenses expense =
                      controller.expensesInAPeriodFiltered[index];
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      expense.amount.amount(),
                                      style: textStyleTitle,
                                    ),
                                    Expanded(
                                      child: Text(
                                        expense.trnDateTime.toDateLocal(),
                                        textAlign: TextAlign.right,
                                        style: textStyleContent,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  expense.description,
                                  style: textStyleSubtitle,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: fontColorHightlightDark),
                            onPressed: () async {
                              await ExpenseEntryScreen.show(expense);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: fontColorHightlightDark),
                            onPressed: () {
                              controller.deleteExpenseConfirm(expense);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GetX<ExpensesController>(builder: (controller) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.current.total,
                      style: textStyleSubtitle.copyWith(
                        color: fontColorError.theme,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(text: controller.getFilteredTotal.amount()),
                  ],
                  style: textStyleTitle.copyWith(
                    color: fontColorError.theme,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
