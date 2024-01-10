import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutteralarmapp/product/services/notification/notification_service.dart';
import 'package:flutteralarmapp/view/app/alarm/show/show_alarm_view.dart';
import 'package:flutteralarmapp/view/app/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

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
                      onTap: () {
                        Get.to(() => const ShowAlarmView());
                      },
                      title: Text('${controller.alarms[index].title}'),
                      trailing: Text(
                        DateFormat("dd-MM-yyyy")
                            .format(controller.alarms[index].dateTime!),
                      ),
                      subtitle: Text(
                        controller.alarms[index].dateTime!
                                    .difference(DateTime.now())
                                    .inMinutes <
                                0
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
