import 'package:flutter/material.dart';
import 'package:paisa_path/src/di.dart';
import 'package:paisa_path/src/localization/flutter_lang.core.g.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/theme/colors.dart';
import 'package:paisa_path/src/screens/custom_widgets/app_scaffold.dart';
import 'package:restart_app/restart_app.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      changeStyle: true,
      title: Strings.current.changeLanguage,
      body: ListView(
        children: [
          ...FlutterLanguage.supportedLanguages.keys.map(
            (languageCode) => GestureDetector(
              onTap: () {
                DI.globals.languageCode = languageCode;
                //restart the app completely
                Restart.restartApp();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        FlutterLanguage.supportedLanguages[languageCode]!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: fontColorError.theme,
                        ),
                      ),
                      const Spacer(),
                      if (languageCode == DI.globals.languageCode)
                        const Icon(Icons.check),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
