import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShowAlarmView extends StatefulWidget {
  const ShowAlarmView({super.key});

  @override
  State<ShowAlarmView> createState() => _ShowAlarmViewState();
}

class _ShowAlarmViewState extends State<ShowAlarmView> {
  @override
  void initState() {
    super.initState();

    shakeEventListener();
  }

  void shakeEventListener() {
    accelerometerEventStream()
        .throttleTime(
      const Duration(milliseconds: 500),
    )
        .listen((AccelerometerEvent event) {
      if (event.x > 1.5) {
        stopAlarm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Spacer(),
            // Alarm Logosu
            Image.asset(
              'assets/image/alarm_logo.png',
              width: 200.w,
              height: 200.h,
            ),
            Center(
              child: Text(
                "Alarm'ı kapatmak için lütfen telefonu sürekli sallayınız",
                style: TextStyle(fontSize: 40.sp),
              ),
            ),
            SizedBox(height: 16),
            const Spacer(),
            IconButton(
              iconSize: 75.sp,
              onPressed: () async {
                stopAlarm();
              },
              icon: const Icon(Icons.arrow_circle_left_outlined),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void stopAlarm() async {
  AudioPlayer().stop();
  AndroidAlarmManager.cancel(0);
  exit(0);
}
