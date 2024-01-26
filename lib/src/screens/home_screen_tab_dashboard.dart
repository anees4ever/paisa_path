import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:paisa_path/src/screens/expenses_list_screen.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/theme/styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                Get.to(() => const ExpensesListScreen());
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
