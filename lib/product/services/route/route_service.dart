import 'package:flutteralarmapp/view/app/app_controller.dart';
import 'package:flutteralarmapp/view/app/app_main.dart';
import 'package:flutteralarmapp/view/splash/controller/splash_controller.dart';
import 'package:flutteralarmapp/view/splash/error_view.dart';
import 'package:flutteralarmapp/view/splash/view/splash_view.dart';
import 'package:get/get.dart';

class RouteService {
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: error,
      page: () => const ErrorView(),
    ),
    GetPage(
      name: app,
      page: () => const AppMain(),
      binding: AppBinding(),
    ),
  ];

  static String splash = "/";
  static String getSplashRoute() => splash;

  static String error = "/error";
  static String getErrorRoute() => error;

  static String app = "/app";
  static String getHomeRoute() => app;
}
