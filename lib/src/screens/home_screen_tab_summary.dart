import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/summary_controller.dart';
import 'package:paisa_path/src/extentions/datetime.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/date_picker.dart';
import 'package:paisa_path/src/screens/custom_widgets/textfield.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/theme/styles.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SummaryController summaryController = Get.put(SummaryController())
      ..generateSummary();
    TextEditingController filterTypeController = TextEditingController(
      text: summaryController.filterType.value.label,
    );
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: EditBox(
                  labelText: Strings.current.filter,
                  readOnly: true,
                  controller: filterTypeController,
                  suffixIcon: Icons.arrow_drop_down,
                  onTap: () {
                    summaryController.showDateFilter(
                      (p0) {
                        fromDateController.text =
                            summaryController.fromDate.value.formattedDate();
                        toDateController.text =
                            summaryController.toDate.value.formattedDate();
                        return filterTypeController.text = p0.label;
                      },
                    );
                  },
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DatePicker(
                  label: Strings.current.from,
                  controller: fromDateController,
                ),
              ),
              Expanded(
                child: DatePicker(
                  label: Strings.current.to,
                  controller: toDateController,
                ),
              ),
            ],
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GetX<SummaryController>(builder: (_) {
                    return PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {},
                        ),
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 1,
                        centerSpaceRadius: 100,
                        sections: getChartSections(summaryController),
                      ),
                    );
                  }),
                  Align(
                    alignment: Alignment.center,
                    child: GetX<SummaryController>(builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Strings.current.total,
                            style: textStyleSubtitle.copyWith(
                              color: fontColorError.theme,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            summaryController.totalAmount.amount(),
                            style: textStyleTitle.copyWith(
                              color: fontColorError.theme,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: GetX<SummaryController>(builder: (_) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                shrinkWrap: true,
                children: summaryController.summaryItems
                    .where((element) => element.amount != 0)
                    .map((element) {
                  int index = summaryController.summaryItems.indexOf(element);
                  return Card(
                    color: ChartColors.get(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          element.typeName,
                          style:
                              textStyleSubtitle.copyWith(color: fontColorDark),
                        ),
                        Text(
                          element.amount.amount(),
                          style: textStyleSubtitle.copyWith(
                            color: fontColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getChartSections(SummaryController controller) {
    double total = controller.summaryItems
        .fold(0, (previousValue, element) => previousValue + element.amount);
    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 1,
          title: '',
          radius: 30,
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide(color: Colors.white.withOpacity(0)),
        )
      ];
    }
    return controller.summaryItems.map((element) {
      int index = controller.summaryItems.indexOf(element);
      return PieChartSectionData(
        color: ChartColors.get(index),
        value: element.amount,
        title: '',
        radius: 30,
        titlePositionPercentageOffset: 0.55,
        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
      );
    }).toList();
  }
}

class ChartColors {
  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  static Color get(int index) {
    switch (index % 10) {
      case 0:
        return ChartColors.contentColorBlue;
      case 1:
        return ChartColors.contentColorYellow;
      case 2:
        return ChartColors.contentColorPink;
      case 3:
        return ChartColors.contentColorGreen;
      case 4:
        return ChartColors.contentColorPurple;
      case 5:
        return ChartColors.contentColorOrange;
      case 6:
        return ChartColors.contentColorRed;
      case 7:
        return ChartColors.contentColorCyan;
      case 8:
        return ChartColors.contentColorBlue;
      case 9:
        return ChartColors.contentColorYellow;
      default:
        throw Error();
    }
  }
}
