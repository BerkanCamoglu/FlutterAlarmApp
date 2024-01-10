import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteralarmapp/product/services/notification/notification_service.dart';
import '../cache/local_storage.dart';

class AppInitiliaze {
  Future<void> initBeforeAppStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorage.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await NotificationService.initializeNotification();
    await AndroidAlarmManager.initialize();
  }
}
