import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugasminggu6/models/movie_model.dart';

class CartController extends GetxController {
  RxList<MovieModel> cart = <MovieModel>[].obs;
  GetStorage box = GetStorage();
  Map<String, dynamic> userSession = GetStorage().read('auth');

  // Removing selected item from the list of cart
  void removeSelectedItemFromCart(int index) {
    cart.removeAt(index);

    List<Map<String, dynamic>> items_cart =
        cart.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Increasing qty of the selected item
  void increaseQtyOfSelectedItemInCart(int index) {
    cart[index].qty++;

    List<Map<String, dynamic>> items_cart =
        cart.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Decrease qty of the selected item
  void decreaseQtyOfSelectedItemInCart(int index, MovieModel movieModel) {
    if (movieModel.qty == 1) {
      cart.removeAt(index);
    } else {
      cart[index].qty--;
    }
    List<Map<String, dynamic>> items_cart =
        cart.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // listen for updates the list of cart from session
  void updatingSession() {
    box.listenKey('items_cart', (updatedValue) {
      if (updatedValue is List) {
        cart.clear();
        cart.addAll(updatedValue.map((e) => MovieModel.fromMap(e)).toList());
      }
    });
  }

  // Updating list of cart with the session data
  void getUpdatedSessionCartData() {
    if (box.hasData('items_cart')) {
      List<dynamic> value = GetStorage().read('items_cart');
      if (value is List) {
        cart.clear();
        cart.addAll(value.map((e) => MovieModel.fromMap(e)).toList());
      }
      updatingSession();
    }
  }

  // When transaction has been made,
  // clear the session, set grandTotal to zero
  // remove the dialog and show the snackbar
  void transactionCompleted() {
    box.write("items_cart", []).then((value) {
      cart.clear();
      Get.back();
      Get.snackbar(
        "Message",
        "Transaction Success ! ",
        colorText: Colors.white,
        backgroundColor: Color(0xff4D4D4D),
      );
    });
  }

  // Logout, remove all session
  void logout() {
    box.erase();
    Get.offAllNamed('/splash');
  }

  @override
  void onReady() {
    getUpdatedSessionCartData();
    super.onReady();
  }
}
