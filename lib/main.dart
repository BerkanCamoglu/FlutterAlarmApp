import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteralarmapp/product/services/route/route_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'core/init/app/app_init.dart';

Future<void> main() async {
  await AppInitiliaze().initBeforeAppStart();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteService.getSplashRoute(),
          getPages: RouteService.routes,
        );
      },
    );
  }
}

//TODO:
/*
  Tüm alarmların listeleneceği bir ana sayfa yapılacak
  Alarm ekleme sayfası oluşturulacak
  Vakti gelen alarmı kapatıcağımız bir sayfa oluşturulacak
 */