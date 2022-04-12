import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/home_controller.dart';
import 'package:tugasminggu6/services/get_tmdb_api.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => GetTMDBapi());
  }
}
