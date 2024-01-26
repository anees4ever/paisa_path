import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/extentions/double.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/theme/styles.dart';

class SummaryScreen extends StatelessWidget {
  SummaryScreen({super.key});

  int touchedIndex = -1;

  ExpensesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
                startDegreeOffset: 180,
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 1,
                centerSpaceRadius: 70,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            shrinkWrap: true,
            children: controller.expenseTypes.map((element) {
              int index = controller.expenseTypes.indexOf(element);
              return Card(
                color: chartColor(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      element.name,
                      style: textStyleSubtitle.copyWith(color: fontColorDark),
                    ),
                    Text(
                      200.00.amount(),
                      style: textStyleSubtitle.copyWith(
                        color: fontColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return controller.expenseTypes.map((element) {
      int index = controller.expenseTypes.indexOf(element);
      return PieChartSectionData(
        color: chartColor(index),
        value: 10 * (index + 1).toDouble(),
        title: '',
        radius: 80,
        titlePositionPercentageOffset: 0.55,
        borderSide: index == touchedIndex
            ? const BorderSide(color: Colors.white, width: 6)
            : BorderSide(color: Colors.white.withOpacity(0)),
      );
    }).toList();
  }
}

//Unlimited list of colors for the chart by index
Color chartColor(int index) {
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

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
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
}
