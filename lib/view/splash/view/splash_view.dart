import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteralarmapp/view/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      initState: (state) {
        state.controller ?? Get.find<SplashController>();
      },
      builder: (controller) => _scaffold,
    );
  }

  Scaffold get _scaffold {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody,
    );
  }

  SizedBox get _buildBody {
    return SizedBox(
      width: 390.w,
      height: 844.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterLogo(
            size: 225.sp,
          ),
          Text(
            "Flutter Mobil Programlama Ödevi",
            style: TextStyle(fontSize: 25.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
