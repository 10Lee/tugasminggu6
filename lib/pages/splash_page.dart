import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/splash_controller.dart';
import 'package:tugasminggu6/global_variable.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: Color(0xF151A1E),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
                image: AssetImage(GlobalVar.splashUrl),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text("D  A  R  K  C  I  N  E  M  A",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Center(
            child: Container(
                width: 260.0,
                margin: const EdgeInsets.only(top: 90.0),
                child: LinearProgressIndicator()),
          ),
          Container(
            margin: const EdgeInsets.only(top: 180.0),
            child: Center(
              child: Text("T   I   C   K   E   T   S",
                  style: TextStyle(color: Colors.white54, fontSize: 20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
