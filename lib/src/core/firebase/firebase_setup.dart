import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:paisa_path/firebase_options.dart';
import 'package:paisa_path/di.dart';
import 'package:paisa_path/src/core/extentions/datetime.dart';
import 'package:paisa_path/src/core/extentions/strings.dart';
import 'package:paisa_path/src/core/firebase/notification.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';

final class FirebaseSetup {
  static initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kReleaseMode) {
      //enable crashlytics in release mode only
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    NotificationSettings settings = await _requestFirebasePermissions();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _listenToFCM();
    }
    await requestLocalNotificationPermissions();

    //schedule daily reminder
    scheduleDailyNotification();
  }

  static scheduleDailyNotification() async {
    String time = DI.globals.dailyReminderTime;
    if (time.isEmpty) {
      time = '20:00:00';
    }
    var dateTime = '${DateTime.now().dbDate()} $time'.toDateTime();

    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    scheduleANotificationAt(
      Strings.current.recordYourExpenses,
      Strings.current.recordYourExpensesMessage,
      dateTime,
    );
  }

  static Future<NotificationSettings> _requestFirebasePermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    return settings;
  }

  static _listenToFCM() async {
    // subscribe to topic on each app start-up
    await FirebaseMessaging.instance.subscribeToTopic('daily_reminder');
    var deviceToken = await FirebaseMessaging.instance.getToken();
    debugPrint('Device Token: $deviceToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        showNotification(
            message.notification!.title!, message.notification!.body!);
        _handleIncomingNotification(message);
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // open from notification
    if (initialMessage != null) {
      _handleIncomingNotification(initialMessage);
    }

    // when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_messageHandlerOpenedApp);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
  _handleIncomingNotification(message);
}

_messageHandlerOpenedApp(RemoteMessage message) async {
  _handleIncomingNotification(message);
}

_handleIncomingNotification(RemoteMessage message) async {}
