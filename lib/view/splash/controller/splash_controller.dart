import 'package:flutteralarmapp/product/services/route/route_service.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(microseconds: 1),
      () async {
        bool hasConnection = await InternetConnectionChecker().hasConnection;
        if (hasConnection == true) {
          Get.offNamed(RouteService.home);
        } else {
          Get.offNamed(RouteService.error);
        }
      },
    );
    super.onInit();
  }
}
