import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugasminggu6/app_routes.dart';

class SplashController extends GetxController {
  void checkAuth() {
    Timer(Duration(seconds: 2), () {
      if (GetStorage().hasData('auth')) {
        Get.offAllNamed(AppRoutes.homeRoute);
      } else {
        Get.offAllNamed(AppRoutes.registerRoute);
      }
    });
  }

  @override
  void onReady() {
    checkAuth();
    super.onReady();
  }
}
