import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/extentions/datetime.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/app_scaffold.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/theme/styles.dart';

class ExpensesListScreen extends StatelessWidget {
  const ExpensesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.current.expenses,
      body: Column(
        children: [
          //const Divider(),

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
                                  Row(
                                    children: [
                                      Text(
                                        controller.expensesToday[index].amount
                                            .amount(),
                                        style: textStyleTitle,
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                              .expensesToday[index].trnDateTime
                                              .formatDateTime(),
                                          textAlign: TextAlign.right,
                                          style: textStyleContent,
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}
