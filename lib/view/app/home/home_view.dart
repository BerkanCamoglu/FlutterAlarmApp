import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutteralarmapp/view/app/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {
        state.controller ?? Get.find<HomeController>();
        state.controller?.onInit();
      },
      builder: (controller) {
        return buildBody(controller);
      },
    );
  }

  Widget buildBody(HomeController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.alarms.isEmpty) {
              return Center(child: Text("Yaklaşan Alarmınız yok."));
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.alarms.length,
              itemBuilder: (context, index) {
                var alarm = controller.alarms[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.yellow,
                    ),
                    child: ListTile(
                      onTap: () async {
                        //Get.to(() => const ShowAlarmView());
                        var durum = await AndroidAlarmManager.oneShot(
                          const Duration(seconds: 5),
                          alarm.id!,
                          fireAlarm,
                        );
                        print(durum);
                      },
                      title: Text('${alarm.title}'),
                      trailing: Text(
                        DateFormat("dd-MM-yyyy").format(alarm.dateTime!),
                      ),
                      subtitle: Text(
                        alarm.dateTime!.difference(DateTime.now()).inMinutes < 0
                            ? "Alarmınızın süresi geçti"
                            : "Alarmınızın Süresine ${controller.alarms[index].dateTime!.difference(DateTime.now()).inMinutes} dakika kaldı",
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

void fireAlarm() {
  print('Alarm Fired at ${DateTime.now()}');
}
