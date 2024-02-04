import 'package:flutter_lang/src_new/annotations.dart';
import 'package:get/route_manager.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.core.g.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.lang.g.dart';

@FlutterLangSingleton.local(
  localFile: './assets/languages_data.json',
  defaultLanguage: 'en',
  stateManagement: StateManagement.NONE,
)
class Strings {
  static FlutterLanguage get current => Get.context == null
      ? FlutterLanguageEN()
      : FlutterLanguage.of(Get.context!);
}

extension StringParamExtension on String {
  String withParam(dynamic param) {
    return withParams([param]);
  }

  String withParams(List<dynamic> params) {
    //return the string itself if no params are passed
    if (params.isEmpty) return this;
    //replace the placeholder %s with the params in the order they are passed
    String result = this;
    for (int i = 0; i < params.length; i++) {
      result = result.replaceFirst('%s', params[i].toString());
    }
    return result;
  }
}
