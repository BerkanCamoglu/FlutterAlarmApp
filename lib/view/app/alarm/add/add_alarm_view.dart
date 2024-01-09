import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteralarmapp/view/app/alarm/add/add_alarm_view_controller.dart';
import 'package:get/get.dart';

class AddAlarmView extends StatelessWidget {
  const AddAlarmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAlarmViewController>(
      init: AddAlarmViewController(),
      builder: (controller) {
        return buildScaffold(context, controller);
      },
    );
  }

  Scaffold buildScaffold(
      BuildContext context, AddAlarmViewController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 360.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: MaterialButton(
                onPressed: () => controller.selectDate(),
                child: controller.selectedDate == null
                    ? Text("Tarih Seç")
                    : Text(
                        'Seçilen Tarih: ${controller.selectedDate!.toIso8601String().split('T')[0]}',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Container(
              width: 360.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: MaterialButton(
                onPressed: () => controller.selectTime(),
                child: controller.selectedTime == null
                    ? Text("Saati Seçiniz")
                    : Text(
                        'Seçilen Tarih: ${controller.selectedTime!.format(context)}',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 360.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: MaterialButton(
                onPressed: () {
                  controller.pickRingtone(context);
                },
                child: controller.selectedRingtone.value.isEmpty
                    ? const Text('Zil Sesi Seç')
                    : Obx(() => Text(
                        'Selected Ringtone: ${controller.selectedRingtone}')),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) => controller.onDescriptionChanged(value),
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              items: [5, 10, 15, 30, 60]
                  .map((minutes) => DropdownMenuItem(
                        value: minutes,
                        child: Text('$minutes Dakika Önce'),
                      ))
                  .toList(),
              value: controller.notificationMinutes,
              decoration: const InputDecoration(
                labelText: 'Bildirim Süresi',
                border: OutlineInputBorder(),
              ),
              onChanged: (int? value) =>
                  controller.onNotificationMinutesChanged(value),
            ),
          ],
        ),
      ),
    );
  }
}
