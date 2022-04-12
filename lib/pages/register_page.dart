import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/register_controller.dart';
import 'package:tugasminggu6/pages/widgets/password_input.dart';
import 'package:tugasminggu6/pages/widgets/regular_input.dart';

class RegisterPage extends StatelessWidget {
  late RegisterController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.find<RegisterController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width / 1.05,
              height: MediaQuery.of(context).size.height / 1.2,
              child: Form(
                key: controller.globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                    ),
                    RegularInputField(titleField: 'Name'),
                    RegularInputField(titleField: 'Email'),
                    PasswordInput(titleField: 'Password'),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () => controller.saveSession(),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text('Register'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
