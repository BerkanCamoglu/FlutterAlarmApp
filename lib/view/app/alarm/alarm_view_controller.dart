import 'package:flutter/material.dart';
import 'package:flutteralarmapp/product/models/alarm_model.dart';
import 'package:flutteralarmapp/product/services/database/alarm_database_provider.dart';
import 'package:get/get.dart';

class AlarmViewController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final database = AlarmDatabaseProvider.instance;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String alarmTitle = '';
  int notificationMinutes = 5;

  void isLoadingChange() {
    isLoading.value = !isLoading.value;
  }

  Future<void> getAlarm() async {
    isLoadingChange();
    var dbAlarms = await database.getAll();
    if (dbAlarms != null) {
      alarms.value = dbAlarms;
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
    getAlarm();
    super.onInit();
  }

  Future<void> deleteAlarm(AlarmModel alarm) async {
    alarms.removeWhere((element) => element == alarm);
    await database.delete(alarm.id!);
  }

  void showEditAlertDialog(AlarmModel alarm) {
    TextEditingController titleController =
        TextEditingController(text: alarm.title);

    Get.defaultDialog(
      title: "Alarm Düzenle",
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Alarm Başlığı"),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await selectDate();
                },
                child: Text("Tarih Seç"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  await selectTime();
                },
                child: Text("Saat Seç"),
              ),
            ],
          ),
        ],
      ),
      textCancel: "İptal",
      textConfirm: "Kaydet",
      onCancel: () {
        // İptal butonuna tıklanınca yapılacak işlemler
      },
      onConfirm: () {
        alarm.title = titleController.text;
        alarm.dateTime = selectedDate == null || selectedTime == null
            ? alarm.dateTime
            : combineDateAndTime(selectedDate!, selectedTime!);
        database.update(alarm.id!, alarm);
        update();
        Get.back();
      },
    );
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
