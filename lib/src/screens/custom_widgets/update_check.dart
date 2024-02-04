import 'dart:io' show Platform;

import 'package:paisa_path/src/core/theme/colors.dart';
import 'package:paisa_path/src/screens/custom_widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateChecker extends StatefulWidget {
  const UpdateChecker({super.key});
  @override
  UpdateCheckerState createState() => UpdateCheckerState();
}

class UpdateCheckerState extends State<UpdateChecker> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      if (_updateInfo == null) {
        checkForUpdate();
      }
    }
  }

  //AUTO-UPDATE LOGIC
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  AppUpdateInfo? _updateInfo;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    _updateInfo =
        null; //AppUpdateInfo(UpdateAvailability.updateAvailable, true, true, 10, InstallStatus.pending, "packageName", 25, 1);
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        setState(() {
          _updateInfo = info;
        });
      }
    }).catchError((e) {
      debugPrint("$e");
      //showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
  //AUTO-UPDATE LOGIC

  @override
  Widget build(BuildContext context) {
    if (_updateInfo == null) {
      return const SizedBox();
    }

    return Container(
      key: scaffoldKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff4f1ed2), width: 1),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff4f1ed2),
                    blurRadius: 10,
                    offset: Offset(1, 1)),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Text(
                "New version ${_updateInfo?.availableVersionCode} is available. Update Now?",
                style: const TextStyle(
                  fontSize: 16,
                  color: appBarColorDark,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTextButton(
                    title: "Later",
                    onPressed: () {
                      setState(
                        () {
                          _updateInfo = null;
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  getTextButton(
                    title: "Update Now",
                    onPressed: () {
                      InAppUpdate.performImmediateUpdate().catchError(
                        (e) {
                          showSnack(e.toString());
                          return e;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
