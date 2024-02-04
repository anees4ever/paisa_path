import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_path/src/controllers/theme_controller.dart';
import 'package:paisa_path/di.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.core.g.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:paisa_path/src/screens/custom_widgets/date_picker.dart';
import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/core/theme/styles.dart';
import 'package:restart_app/restart_app.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //show a rectangular box on top 30% of the screen with Light color and Dark color with a toggle button on the middle to switch the theme, use stack
        Text(
          Strings.current.colorScheme,
          textAlign: TextAlign.center,
          style: textStyleTitle,
        ),
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: appBarColorLight,
                      child: Center(
                        child: Text(
                          Strings.current.light,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fontColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: appBarColorDark,
                      child: Center(
                        child: Text(
                          Strings.current.dark,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fontColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: GetX<ThemeController>(builder: (controller) {
                return Switch(
                  value: controller.currentThemeMode.value == ThemeMode.dark,
                  onChanged: (value) => controller.toggleTheme(),
                  thumbColor: MaterialStateProperty.all(appBarColorLight),
                  trackColor: MaterialStateProperty.all(fontColorDark),
                  trackOutlineColor: MaterialStateProperty.all(fontColorLight),
                  overlayColor: MaterialStateProperty.all(fontColorDark),
                  thumbIcon: MaterialStateProperty.all(
                    const Icon(
                      Icons.circle,
                      color: appBarColorLight,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 20),
        //showing a language selection tiles
        Text(
          Strings.current.language,
          textAlign: TextAlign.center,
          style: textStyleTitle,
        ),
        ...(FlutterLanguage.supportedLanguages.keys.map(
          (key) => Card(
            color: appBarColor.light,
            child: ListTile(
              title: Text(
                FlutterLanguage.supportedLanguages[key]!,
                style: const TextStyle(color: fontColorDark),
              ),
              trailing: DI.globals.languageCode == key
                  ? const Icon(Icons.check, color: fontColorDark)
                  : null,
              onTap: () {
                //confirm the language change with a restart prompt
                Get.defaultDialog(
                  title: Strings.current.restartApp,
                  middleText: Strings.current.changeLanguageQuestion
                      .withParam(FlutterLanguage.supportedLanguages[key]),
                  textConfirm: Strings.current.ok,
                  textCancel: Strings.current.cancel,
                  onConfirm: () {
                    DI.globals.languageCode = key;
                    Restart.restartApp();
                  },
                  confirmTextColor: fontColorDark,
                  cancelTextColor: fontColorDark,
                  buttonColor: appBarColorLight,
                );
              },
            ),
          ),
        )).toList(),
        const SizedBox(height: 20),

        //daily reminder time for expense entry
        Text(
          Strings.current.dailyReminderAt,
          textAlign: TextAlign.center,
          style: textStyleTitle,
        ),
        Row(
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: TimePicker(
                label: '',
                initialTime: DI.globals.dailyReminderTimeAsDate,
                onSelected: (selectedTime) {
                  if (selectedTime != null) {
                    DI.globals.dailyReminderTime = selectedTime.dbTime();
                  }
                },
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),

        const Divider(),

        const SizedBox(height: 20),
        //showing a button to open the expense type screen
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getElevatedButton(
              title: Strings.current.manage
                  .withParam(Strings.current.expenseTypes),
              onPressed: () => Get.toNamed('/expenseTypes'),
            ),
          ],
        ),
      ],
    );
  }
}
