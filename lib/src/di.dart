import 'package:get/instance_manager.dart';
import 'package:paisa_path/src/controllers/expenses_controller.dart';
import 'package:paisa_path/src/controllers/theme_controller.dart';
import 'package:paisa_path/src/controllers/globals_controller.dart';
import 'package:paisa_path/src/database/floor_database.dart';

sealed class DI {
  static Future<void> process() async {
    Get.put(ThemeController(), permanent: true);

    GlobalsController globals = Get.put(GlobalsController(), permanent: true);

    await globals.initDb();
    await globals.initPref();

    Get.put(ExpensesController(), permanent: true);
  }

  //get a dependancy from the DI
  static T get<T>() {
    return Get.find<T>();
  }

  //get GlobalController
  static GlobalsController get globals {
    return Get.find<GlobalsController>();
  }

  static AppDatabase get db {
    return Get.find<GlobalsController>().database;
  }
}
