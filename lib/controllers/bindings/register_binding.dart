import 'package:get/instance_manager.dart';
import 'package:tugasminggu6/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
