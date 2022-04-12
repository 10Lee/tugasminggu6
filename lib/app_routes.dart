import 'package:get/route_manager.dart';
import 'package:tugasminggu6/controllers/bindings/cart_binding.dart';
import 'package:tugasminggu6/controllers/bindings/home_binding.dart';
import 'package:tugasminggu6/controllers/bindings/register_binding.dart';
import 'package:tugasminggu6/controllers/bindings/splash_binding.dart';
import 'package:tugasminggu6/pages/cart_page.dart';
import 'pages/_pages.dart';

class AppRoutes {
  static String homeRoute = '/home';
  static String registerRoute = '/register';
  static String cartRoute = '/cart';
  static String splashRoute = '/splash';

  List<GetPage> routes = [
    GetPage(
      name: homeRoute,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: cartRoute,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: registerRoute,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: splashRoute,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}
