// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:flutteralarmapp/core/extensions/context_extension.dart';
import 'package:flutteralarmapp/product/models/alarm_model.dart';
import 'package:flutteralarmapp/product/services/database/alarm_database_provider.dart';
import 'package:flutteralarmapp/product/services/notification/notification_service.dart';
import 'package:flutteralarmapp/view/app/app_controller.dart';
import 'package:flutteralarmapp/view/app/app_main.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AddAlarmViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAlarmViewController());
  }
}

class AddAlarmViewController extends GetxController {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String alarmTitle = '';
  int notificationMinutes = 5;
  final AudioPlayer audioPlayer = AudioPlayer();
  RxString selectedRingtone = ''.obs;
  RxString selectedRingtonePath = ''.obs;

  final AlarmDatabaseProvider database = AlarmDatabaseProvider.instance;

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      update(); // Widget'ı güncellemek için
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
      update(); // Widget'ı güncellemek için
    }
  }

  void onAlarmTitleChanged(String value) {
    alarmTitle = value;
  }

  void onNotificationMinutesChanged(int? value) {
    if (value != null) {
      notificationMinutes = value;
    }
  }

  Future<void> pickRingtone(BuildContext context) async {
    var ringtones = await FlutterSystemRingtones.getRingtoneSounds();

    Get.bottomSheet(
      SizedBox(
        height: 500.h,
        child: ListView(
          padding: context.paddingLow,
          shrinkWrap: true,
          children: [
            Container(
              width: 375.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialButton(
                child: const Text('Kaydet'),
                onPressed: () async {
                  await stopRingtone();
                  Get.back();
                },
              ),
            ),
            const Divider(),
            ...ringtones.map((Ringtone ringtone) {
              return ListTile(
                title: Text(ringtone.title),
                onTap: () async {
                  await playRingtone(ringtone.uri);
                  selectedRingtone.value = ringtone.title;
                  selectedRingtonePath.value = ringtone.uri;
                },
              );
            }).toList(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> playRingtone(String uri) async {
    await audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri)),
    );
    await audioPlayer.play();
  }

  Future<void> stopRingtone() async {
    await audioPlayer.stop();
  }

  Future<void> saveRingtone() async {
    var entity = AlarmModel(
      title: alarmTitle,
      ringtoneTitle: selectedRingtone.value,
      ringtonePath: selectedRingtonePath.value,
      dateTime: combineDateAndTime(selectedDate!, selectedTime!),
    );
    await database.add(entity);
    await NotificationService.showNotification(
      title: alarmTitle,
      body: "Alarmınzın çalmasına $notificationMinutes dakika kaldı.",
      scheduled: true,
      interval: combineDateAndTime(selectedDate!, selectedTime!)
              .difference(DateTime.now())
              .inSeconds -
          60 * notificationMinutes,
    );

    Get.offAll(
      () => const AppMain(),
      binding: AppBinding(),
      transition: Transition.zoom,
    );
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
