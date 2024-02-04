import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/summary_controller.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/models/enum_filter_date_types.dart';
import 'package:paisa_path/src/screens/custom_widgets/amount_view_card.dart';
import 'package:paisa_path/src/screens/custom_widgets/custom_dropdown.dart';
import 'package:paisa_path/src/screens/custom_widgets/date_picker.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SummaryController summaryController = Get.put(SummaryController())
      ..generateSummary();
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          const SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: customDropdown(
                  label: Strings.current.filter,
                  value: summaryController.filterType.value.index,
                  onChanged: (int? value) {
                    summaryController.filterType(value == null
                        ? FilterDateTypes.today
                        : FilterDateTypes.values[value]);
                    summaryController.updateFromToDates();
                    fromDateController.text =
                        summaryController.fromDate.value.formatLocal();
                    toDateController.text =
                        summaryController.toDate.value.formatLocal();
                    summaryController.generateSummary();
                  },
                  dropdownItems: [
                    ...FilterDateTypes.values.toDropdownList(),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
          GetX<SummaryController>(builder: (_) {
            if (summaryController.filterType.value != FilterDateTypes.custom) {
              return const SizedBox();
            }
            return Row(
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
            );
          }),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GetX<SummaryController>(builder: (_) {
                  if (summaryController.selectedChartType.value ==
                      SelectedChartType.pie) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
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
                      ),
                    );
                  } else if (summaryController.selectedChartType.value ==
                      SelectedChartType.bar) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: summaryController.maxAmount,
                          titlesData: const FlTitlesData(
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: const FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: summaryController.summaryItems
                              .map(
                                (e) => BarChartGroupData(
                                  x: summaryController.summaryItems.indexOf(e),
                                  barRods: [
                                    BarChartRodData(
                                        width: 16,
                                        toY: e.amount,
                                        color: ChartColors.get(summaryController
                                            .summaryItems
                                            .indexOf(e))),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                GetX<SummaryController>(builder: (_) {
                  if (summaryController.selectedChartType.value ==
                      SelectedChartType.bar) {
                    return const SizedBox();
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
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
                    ),
                  );
                }),
                Positioned(
                  right: 16,
                  bottom: 16.0,
                  child: GetX<SummaryController>(builder: (_) {
                    return FloatingActionButton.small(
                      onPressed: () {
                        summaryController.selectedChartType.value =
                            summaryController.selectedChartType.value ==
                                    SelectedChartType.bar
                                ? SelectedChartType.pie
                                : SelectedChartType.bar;
                      },
                      child: Icon(summaryController.selectedChartType.value ==
                              SelectedChartType.bar
                          ? Icons.pie_chart
                          : Icons.bar_chart),
                    );
                  }),
                ),
              ],
            ),
          ),
          GetX<SummaryController>(builder: (_) {
            if (summaryController.selectedChartType.value ==
                SelectedChartType.pie) {
              return const SizedBox();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${Strings.current.total}: ',
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
                  return AmountViewCard(
                    element.typeName,
                    element.amount,
                    color: ChartColors.get(index),
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
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
  static const Color contentColorBrown = Color(0xFF8B4513);
  static const Color contentColorGray = Color(0xFF808080);
  static const Color contentColorTeal = Color(0xFF008080);
  static const Color contentColorLime = Color(0xFF00FF00);

  // get color from 12 colors above by an index for n number of list
  static Color get(int index) {
    switch (index % 12) {
      case 0:
        return contentColorBlue;
      case 1:
        return contentColorYellow;
      case 2:
        return contentColorPink;
      case 3:
        return contentColorGreen;
      case 4:
        return contentColorPurple;
      case 5:
        return contentColorOrange;
      case 6:
        return contentColorRed;
      case 7:
        return contentColorCyan;
      case 8:
        return contentColorBrown;
      case 9:
        return contentColorGray;
      case 10:
        return contentColorTeal;
      case 11:
        return contentColorLime;
      default:
        throw Error();
    }
  }
}
