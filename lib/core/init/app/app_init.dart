import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../cache/local_storage.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class AppInitiliaze {
  Future<void> initBeforeAppStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorage.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await initializeNotifications();
    tz.initializeTimeZones();
  }
}

/* Future<void> initializeNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(
        const AndroidNotificationChannel(
          "cbf4294a-50a6-46d5-b8f2",
          "Flutter Alarm App",
          importance: Importance.max,
        ),
      );

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettings = const InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: (details) {
      
    },
  );
}
 */

Future<void> initializeNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettings = const InitializationSettings(
    android: androidInitializationSettings,
    iOS: null,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}
