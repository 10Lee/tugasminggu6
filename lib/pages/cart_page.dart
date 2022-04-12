import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/cart_controller.dart';
import 'package:tugasminggu6/services/get_tmdb_api.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        actions: [
          IconButton(
              onPressed: () => controller.logout(), icon: Icon(Icons.logout))
        ],
      ),
      body: Obx(
        () => controller.cart.isEmpty
            ? const Center(
                child: Text("Your Cart is Empty",
                    style: TextStyle(fontSize: 18.0)),
              )
            : Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) {
                          var cartData = controller.cart[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                  ),
                                  child: Image(
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        GetTMDBapi.imageBaseUrl +
                                            cartData.posterPath),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 108.0,
                                    color: Colors.white.withOpacity(.05),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  cartData.title.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              InkWell(
                                                onTap: () => controller
                                                    .removeSelectedItemFromCart(
                                                        index),
                                                child: Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Text(
                                                "Tickets :",
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(width: 20.0),
                                              Text(
                                                "${cartData.qty}",
                                                style: const TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => controller
                                          .decreaseQtyOfSelectedItemInCart(
                                              index, cartData),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20.0),
                                            )),
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => controller
                                          .increaseQtyOfSelectedItemInCart(
                                              index),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20.0),
                                            )),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Do you really want to purcahse?",
                            actions: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel")),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.yellow)),
                                  onPressed: () {
                                    controller.transactionCompleted();
                                  },
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                            backgroundColor: Color(0xff4D4D4D),
                            titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ListView.separated(
                                    separatorBuilder: (_, i) => Divider(),
                                    itemCount: controller.cart.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        leading: Container(
                                          width: 60,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                GetTMDBapi.imageBaseUrl +
                                                    controller
                                                        .cart[index].posterPath,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          controller.cart[index].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    "Name: " +
                                        controller.userSession["name"]
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    "Email : " +
                                        controller.userSession["email"]
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Center(
                            child: Text(
                              "Purchase",
                              style: const TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
      ),
    );
  }
}
