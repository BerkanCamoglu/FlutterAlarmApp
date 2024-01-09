import 'package:flutter/material.dart';
import 'package:flutteralarmapp/view/app/alarm/alarm_view_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlarmView extends StatelessWidget {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmViewController>(
      initState: (state) {
        state.controller ?? Get.find<AlarmViewController>();
        state.controller?.onInit();
      },
      builder: (controller) {
        return buildBody(controller);
      },
    );
  }

  ListView buildBody(AlarmViewController controller) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                    title: Text('${controller.alarms[index].title}'),
                    subtitle: Text(
                      DateFormat("dd-MM-yyyy HH:mm")
                          .format(controller.alarms[index].dateTime!),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue[900],
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue[900],
                          ),
                          onPressed: () {
                            var alarm = controller.alarms[index];
                            controller.deleteAlarm(alarm);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
