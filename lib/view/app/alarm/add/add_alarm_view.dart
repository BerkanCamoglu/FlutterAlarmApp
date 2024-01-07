// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class AddAlarmView extends StatefulWidget {
  const AddAlarmView({super.key});

  @override
  _AddAlarmViewState createState() => _AddAlarmViewState();
}

class _AddAlarmViewState extends State<AddAlarmView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedRingtone = 'Default Ringtone';
  String alarmDescription = '';
  int notificationMinutes = 5;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Tarih Seç'),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text('Saat Seç'),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: selectedRingtone,
              items:
                  ['Default Ringtone', 'Ringtone 1', 'Ringtone 2', 'Ringtone 3']
                      .map((ringtone) => DropdownMenuItem(
                            value: ringtone,
                            child: Text(ringtone),
                          ))
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRingtone = value as String;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Zil Sesi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  alarmDescription = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: notificationMinutes,
              items: [5, 10, 15, 30, 60]
                  .map((minutes) => DropdownMenuItem(
                        value: minutes,
                        child: Text('$minutes Dakika Önce'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  notificationMinutes = value as int;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Bildirim Süresi',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
