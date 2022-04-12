import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugasminggu6/app_routes.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  RxBool isObsecure = true.obs;
  String name = '', email = '', password = '';

  void toggleObsecure() {
    if (isObsecure == true) {
      isObsecure.value = false;
    } else {
      isObsecure.value = true;
    }
  }

  void saveSession() {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();

      Map<String, dynamic> registeredAuth = {
        'name': name,
        'email': email,
        'password': password,
      };

      GetStorage().write('auth', registeredAuth);
      Get.offAllNamed(AppRoutes.splashRoute);
    }
  }
}
