import 'package:flutter/material.dart';
import 'package:paisa_path/src/extentions/datetime.dart';
import 'package:paisa_path/src/screens/custom_widgets/textfield.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {super.key,
      required this.label,
      this.onSelected,
      this.initialDate,
      this.controller});

  final String label;
  final DateTime? initialDate;
  final void Function(DateTime?)? onSelected;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController =
        controller ?? TextEditingController();
    dateController.text = (initialDate ?? DateTime.now()).formattedDate();
    return EditBox(
      controller: dateController,
      labelText: label,
      readOnly: true,
      suffixIcon: Icons.calendar_today_outlined,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2050),
        );
        if (newDate != null) {
          dateController.text = newDate.formattedDate();
          if (onSelected != null) {
            onSelected!(newDate);
          }
        }
      },
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key? key,
    required this.label,
    this.onSelected,
    this.initialTime,
    this.controller,
  });

  final String label;
  final DateTime? initialTime;
  final void Function(DateTime?)? onSelected;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController =
        controller ?? TextEditingController();
    timeController.text = (initialTime ?? DateTime.now()).formattedTime();
    return EditBox(
      controller: timeController,
      labelText: label,
      readOnly: true,
      suffixIcon: Icons.access_time,
      onTap: () async {
        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: initialTime != null
              ? TimeOfDay.fromDateTime(initialTime!)
              : TimeOfDay.now(),
        );
        if (newTime != null) {
          DateTime newDate = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, newTime.hour, newTime.minute);
          timeController.text = newDate.formattedTime();
          if (onSelected != null) {
            onSelected!(newDate);
          }
        }
      },
    );
  }
}
