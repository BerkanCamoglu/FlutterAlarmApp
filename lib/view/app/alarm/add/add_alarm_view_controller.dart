import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:flutteralarmapp/core/extensions/context_extension.dart';
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
  String alarmDescription = '';
  int notificationMinutes = 5;
  final AudioPlayer audioPlayer = AudioPlayer();

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

  void onDescriptionChanged(String value) {
    alarmDescription = value;
  }

  void onNotificationMinutesChanged(int? value) {
    if (value != null) {
      notificationMinutes = value;
    }
  }

  RxString selectedRingtone = ''.obs;

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
                child: Text('Kaydet'),
                onPressed: () async {
                  await stopRingtone();
                  Get.back();
                },
              ),
            ),
            Divider(),
            ...ringtones.map((Ringtone ringtone) {
              return ListTile(
                title: Text(ringtone.title),
                onTap: () async {
                  await playRingtone(ringtone.uri);
                  selectedRingtone.value = ringtone.title;
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
    // Seçilen zil sesini burada kaydetme işlemlerini gerçekleştirin.
    // Örneğin, tercih edilen veritabanına, Shared Preferences'e vb. kaydedebilirsiniz.
  }
}
