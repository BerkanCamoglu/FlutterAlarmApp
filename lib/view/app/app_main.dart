import 'package:flutter/material.dart';
import 'package:flutteralarmapp/view/app/app_controller.dart';
import 'package:get/get.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      initState: (state) {
        state.controller ?? Get.find<AppController>();
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'AlarmApp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.blue[900],
          ),
          body: Obx(
            () {
              return controller.screens[controller.index.value];
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Ana Sayfa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'Alarmlar',
              ),
            ],
            currentIndex: controller.index.value,
            onTap: controller.onItemTapped,
            selectedItemColor: Colors.blue[900],
            unselectedItemColor: Colors.yellow,
            type: BottomNavigationBarType.fixed,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.navigateAddAlarm();
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
