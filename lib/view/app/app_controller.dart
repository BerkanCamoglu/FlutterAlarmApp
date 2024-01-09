import 'package:flutteralarmapp/view/app/alarm/add/add_alarm_view.dart';
import 'package:flutteralarmapp/view/app/alarm/add/add_alarm_view_controller.dart';
import 'package:flutteralarmapp/view/app/alarm/alarm_view.dart';
import 'package:flutteralarmapp/view/app/alarm/alarm_view_controller.dart';
import 'package:flutteralarmapp/view/app/home/home_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => AlarmViewController());
  }
}

class AppController extends GetxController {
  RxInt index = 0.obs;
  List<Widget> screens = [
    const HomeView(),
    const AlarmView(),
  ];

  void onItemTapped(int i) {
    index.value = i;
  }

  void navigateAddAlarm() {
    Get.to(
      () => const AddAlarmView(),
      binding: AddAlarmViewBinding(),
      transition: Transition.downToUp,
    );
  }
}
