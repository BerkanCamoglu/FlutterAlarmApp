import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteralarmapp/main.dart';
import 'package:get/get.dart';

class ShowAlarmView extends StatelessWidget {
  const ShowAlarmView({super.key});

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
                "Alarm Başlığı",
                style: TextStyle(fontSize: 40.sp),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '08:30 AM',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              iconSize: 75.sp,
              onPressed: () {
                Get.back();
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
