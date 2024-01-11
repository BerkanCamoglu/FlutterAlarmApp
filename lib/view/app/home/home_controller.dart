import 'package:flutteralarmapp/product/models/alarm_model.dart';
import 'package:flutteralarmapp/product/services/database/alarm_database_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final database = AlarmDatabaseProvider.instance;

  void isLoadingChange() {
    isLoading.value = !isLoading.value;
  }

  Future<void> getAlarm() async {
    isLoadingChange();
    var dbAlarms = await database.getAll();
    if (dbAlarms != null) {
      for (var dbAlarm in dbAlarms) {
        if (dbAlarm.dateTime!.difference(DateTime.now()).inMinutes < 14400) {
          alarms.add(dbAlarm);
        }
      }
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

  Future<void> onRefresh() async {
    alarms.clear();
    getAlarm();
  }

  Future<void> deleteAlarm(AlarmModel alarm) async {
    alarms.removeWhere((element) => element == alarm);
    await database.delete(alarm.id!);
  }
}
