import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/amount_view_card.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:paisa_path/src/screens/expense_entry_screen.dart';
import 'package:paisa_path/src/screens/home_screen_tab_summary.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int page) callbackToSetPage;
  const DashboardScreen({super.key, required this.callbackToSetPage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetX<ExpensesController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AmountViewCard(
                      Strings.current.today,
                      controller.expenseTotalToday.value,
                    ),
                  ),
                  Expanded(
                    child: AmountViewCard(
                      Strings.current.thisWeek,
                      controller.expenseTotalThisWeek.value,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AmountViewCard(
                      Strings.current.thisMonth,
                      controller.expenseTotalThisMonth.value,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => callbackToSetPage(1),
                      child: AspectRatio(
                        aspectRatio: 2.5,
                        child: Card(
                          color: ChartColors.contentColorTeal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.pie_chart, color: fontColorDark),
                              Text(Strings.current.summary,
                                  style: textStyleTitle.copyWith(
                                      color: fontColorDark)),
                              const Icon(Icons.arrow_forward_ios,
                                  color: fontColorDark),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),

        const SizedBox(height: 16.0),
        //show title: today's expense
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.current.today,
              style: textStyleTitle,
            ),
            getTextButton(
              title: Strings.current.viewAll,
              child: Row(
                children: [
                  Text(
                    Strings.current.viewAll,
                    style: textStyleSubtitle,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onPressed: () {
                callbackToSetPage(2);
              },
            ),
          ],
        ),
        const Divider(),

        Expanded(
          child: GetX<ExpensesController>(
            builder: (controller) {
              if (controller.expensesToday.isEmpty) {
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
                itemCount: controller.expensesToday.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
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
                                Text(
                                  controller.expensesToday[index].amount
                                      .amount(),
                                  style: textStyleTitle,
                                ),
                                Text(
                                  controller.expensesToday[index].description,
                                  style: textStyleSubtitle,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: fontColorHightlightDark),
                            onPressed: () async {
                              await ExpenseEntryScreen.show(
                                  controller.expensesToday[index]);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: fontColorHightlightDark),
                            onPressed: () {
                              controller.deleteExpenseConfirm(
                                  controller.expensesToday[index]);
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
      ],
    );
  }
}
