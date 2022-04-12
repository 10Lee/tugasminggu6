import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/app_routes.dart';
import 'package:tugasminggu6/controllers/home_controller.dart';
import 'package:tugasminggu6/models/movie_model.dart';
import 'package:tugasminggu6/services/get_tmdb_api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    return Scaffold(
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.cartRoute);
          },
          child: controller.cart.isEmpty
              ? Icon(Icons.shopping_cart, size: 25.0)
              : Badge(
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 25.0,
                  ),
                  badgeColor: Colors.red,
                  badgeContent: Text(
                    '${controller.cart.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                    ),
                  ),
                ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // The blurred backgroud
          Obx(
            () => controller.data.isEmpty
                ? Container()
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      key: ValueKey<String>(
                          controller.data[controller.currentIndex.value].title),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(GetTMDBapi.imageBaseUrl +
                              controller.data[controller.currentIndex.value]
                                  .posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 15,
                          sigmaY: 15,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
          ),

          // This is the image card in center
          Container(
            height: 550.0,
            child: Obx(
              () => PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.data.length,
                onPageChanged: (int page) {
                  // Syncing currentIndex with pageview index
                  controller.currentIndex.value = page;
                },
                itemBuilder: (context, index) {
                  final movieData = controller.data[index];

                  return FractionallySizedBox(
                    widthFactor: .7,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.circular(200.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            )
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              height: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      // controller.data[index],
                                      "${GetTMDBapi.imageBaseUrl}${movieData.posterPath}"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                child: Text(
                                  "${movieData.title}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     controller.clearSessionItemsCart();
                          //     controller.cart.refresh();
                          //   },
                          //   child: Text('Hapus semua data session'),
                          // ),
                          const SizedBox(height: 20.0),
                          Obx(
                            () {
                              MovieModel? selectedModel = controller.cart
                                  .firstWhereOrNull((MovieModel selectedItem) =>
                                      selectedItem.id == movieData.id);
                              if (selectedModel == null) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: 110.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.addItemToCart(movieData);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                );
                              } else {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: 150.0,
                                  height: 100.0,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .decreaseQtyOfItemInCart(
                                                      selectedModel);
                                            },
                                            child: Container(
                                              width: 40.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5.0),
                                          GetBuilder<HomeController>(
                                            init: HomeController(),
                                            builder: (homeController) {
                                              return Container(
                                                width: 30.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2.0,
                                                    )),
                                                child: Center(
                                                  child: Text(
                                                    "${selectedModel.qty}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 5.0),
                                          InkWell(
                                            onTap: () => controller
                                                .increaseQtyOfItemInCart(
                                                    selectedModel),
                                            child: Container(
                                              width: 40.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {
                                          controller.removeSelectedItemFromCart(
                                              selectedModel.id);
                                        },
                                        child: const Text('Remove'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
