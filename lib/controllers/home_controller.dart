import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugasminggu6/app_routes.dart';
import 'package:tugasminggu6/models/movie_model.dart';
import 'package:tugasminggu6/services/get_tmdb_api.dart';

class HomeController extends GetxController {
  GetTMDBapi apiController = Get.find<GetTMDBapi>();

  RxList<MovieModel> data = <MovieModel>[].obs;
  RxList<MovieModel> cart = <MovieModel>[].obs;

  RxInt currentIndex = 0.obs; // This sync with the index in pageview builder
  RxBool isLoading = false.obs;

  GetStorage box = GetStorage();

  int page = 3;

  // API ---------------------------------------
  void getApi() {
    isLoading.value = true;
    apiController.getApiData(page).then((api) {
      data.addAll(api);

      isLoading.value = false;
    }).catchError((error, stackTrace) {
      print("Error : $error");
      print("Error : $stackTrace");
    });
  }
  // -------------------------------------------

  // CART LOGIC -------------------------------
  //  When + button clicked
  void addItemToCart(MovieModel movieModel) {
    movieModel.qty = 1;
    cart.add(movieModel);

    List<Map<String, dynamic>> items_cart =
        cart.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
    Get.snackbar("Success", "Your selected movie has been added to cart");
  }

  // Increase QTY when + button clicked
  void increaseQtyOfItemInCart(MovieModel movieModel) {
    cart.removeWhere((element) => element.id == movieModel.id);
    movieModel.qty++;
    cart.add(movieModel);
    box.write('items_cart', cart.map((e) => e.toJson()).toList());
  }

  // Decrease QTY when - button clicked
  void decreaseQtyOfItemInCart(MovieModel movieModel) {
    if (movieModel.qty == 1) {
      cart.removeWhere((MovieModel e) => e.id == movieModel.id);
    } else {
      cart.removeWhere((MovieModel e) => e.id == movieModel.id);
      movieModel.qty--;
      cart.add(movieModel);

      box.write('items_cart', cart.map((e) => e.toJson()).toList());
    }
  }

  // When Remove button clicked
  void removeSelectedItemFromCart(int id) {
    cart.removeWhere((element) => element.id == id);

    box.write('items_cart', cart.map((e) => e.toJson()).toList());
  }

  // Listen for changes in items_cart session
  void updatingSession() {
    box.listenKey(
      'items_cart',
      (updatedValue) {
        if (updatedValue is List) {
          cart.clear();
          cart.addAll(updatedValue.map((e) => MovieModel.fromMap(e)).toList());
        }
      },
    );
  }

  // Get initial cart value from items_cart session
  void getUpdatedSessionCartData() {
    if (box.hasData('items_cart')) {
      List<dynamic> sessionValue = box.read('items_cart');
      if (sessionValue is List) {
        List<MovieModel> getModelFromSession =
            sessionValue.map((e) => MovieModel.fromMap(e)).toList();
        cart.clear();
        cart.addAll(getModelFromSession);
      }
    }
    updatingSession();
  }

  void logout() {
    box.erase();
    Get.offAllNamed(AppRoutes.splashRoute);
  }

  // -------------------------------------------------------------

  @override
  void onReady() {
    getApi();
    getUpdatedSessionCartData();
    super.onReady();
  }
}
