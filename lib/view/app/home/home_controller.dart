import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutteralarmapp/product/models/alarm_model.dart';
import 'package:flutteralarmapp/product/services/database/alarm_database_provider.dart';
import 'package:flutteralarmapp/product/services/notification/notification_manager.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final database = AlarmDatabaseProvider.instance;
  late final LocalNotificationService service;

  void isLoadingChange() {
    isLoading.value = !isLoading.value;
  }

  Future<void> getAlarm() async {
    isLoadingChange();
    var dbAlarms = await database.getAll();
    if (dbAlarms != null) {
      for (var dbAlarm in dbAlarms) {
        if (dbAlarm.dateTime!.difference(DateTime.now()).inMinutes < 14400) {
          alarms.add(dbAlarm);
        }
      }
    }
    isLoadingChange();
  }

  Future<void> checkDatabaseForNewAlarms() async {
    isLoadingChange();
    var dbAlarms = await database.getAll();
    if (dbAlarms?.length != alarms.length) {
      getAlarm();
    }
    isLoadingChange();
  }

  @override
  void onInit() {
    service = LocalNotificationService();
    service.intialize();

    getAlarm();
    super.onInit();
  }

  Future<void> onRefresh() async {
    alarms.clear();
    getAlarm();
  }

  Future<void> deleteAlarm(AlarmModel alarm) async {
    alarms.removeWhere((element) => element == alarm);
    await database.delete(alarm.id!);
  }

  Future<void> scheduleFutureNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel_id', // Kanal ID, benzersiz bir şekilde adlandırılmalıdır.
      'Alarm Kanalı', // Kanal adı
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Bildirimi zamanlanmış bir şekilde gönder
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2, // Bildirim ID'si, benzersiz bir şekilde atanmalıdır.
      'Alarm Başlığı', // Bildirim başlığı
      'Alarm İçeriği', // Bildirim içeriği
      TZDateTime.from(DateTime.now().add(const Duration(seconds: 5)),
          tz.local), // Bildirimin gönderileceği tarih ve saat
      platformChannelSpecifics,
      payload: 'custom_sound',
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
    }
  }
}
