import 'package:paisa_path/src/di.dart';
import 'package:paisa_path/src/controllers/theme_controller.dart';
import 'package:paisa_path/src/localization/flutter_lang.core.g.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/home_screen.dart';
import 'package:paisa_path/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DI.process();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DI.globals.locale,
          localizationsDelegates: FlutterLanguage.localizationsDelegates,
          supportedLocales: FlutterLanguage.supportedLocales,
          title: Strings.current.appName,
          themeMode: controller.currentThemeMode.value ?? ThemeMode.system,
          theme: ThemeClass.lightTheme(context),
          darkTheme: ThemeClass.darkTheme(context),
          home: const HomeScreen(),
        );
      },
    );
  }
}
