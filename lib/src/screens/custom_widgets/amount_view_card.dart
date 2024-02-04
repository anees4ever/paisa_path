import 'package:flutter/material.dart';
import 'package:paisa_path/src/core/extentions/double.dart';
import 'package:paisa_path/src/screens/home_screen_tab_summary.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';

class AmountViewCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color? color;
  const AmountViewCard(this.label, this.amount, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Card(
        color: color ?? ChartColors.contentColorBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: textStyleSubtitle.copyWith(color: fontColorDark),
            ),
            Text(
              amount.amount(),
              style: textStyleTitle.copyWith(
                color: fontColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
