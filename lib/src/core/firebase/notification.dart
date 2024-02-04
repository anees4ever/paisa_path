import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

int notificationID = 1;

requestLocalNotificationPermissions() async {
  if (Platform.isAndroid) {
    AndroidFlutterLocalNotificationsPlugin().requestExactAlarmsPermission();
  }
}

showNotification(String title, String body) async {
  int currentNotificationID = notificationID++;
  var flip = await prapreFlutterNotificationPlugin();
  var notificationDetails = await getNotificationDetails();
  await flip.show(
    currentNotificationID,
    title,
    body,
    notificationDetails,
    payload: 'Default_Sound',
  );
}

scheduleANotificationAt(String title, String body, DateTime time) async {
  tz.initializeTimeZones();

  int currentNotificationID = notificationID++;
  var flip = await prapreFlutterNotificationPlugin();
  await flip.cancelAll();

  var notificationDetails = await getNotificationDetails();
  await flip.zonedSchedule(
      currentNotificationID,
      title,
      body,
      tz.TZDateTime.from(time, tz.local).add(const Duration(seconds: 5)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

Future<FlutterLocalNotificationsPlugin>
    prapreFlutterNotificationPlugin() async {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iOS = DarwinInitializationSettings();

  const settings = InitializationSettings(android: android, iOS: iOS);
  flip.initialize(settings);

  return flip;
}

Future<NotificationDetails> getNotificationDetails() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'expense_entry_alert_id', Strings.current.recordYourExpenses,
      channelDescription: Strings.current.recordYourExpensesMessage,
      importance: Importance.max,
      priority: Priority.high);

  const iOSPlatformChannelSpecifics =
      DarwinNotificationDetails(threadIdentifier: 'expense_entry_alert_id');

  return NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
}
