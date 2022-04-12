import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/register_controller.dart';

class PasswordInput extends StatelessWidget {
  late String titleField;
  PasswordInput({
    Key? key,
    required this.titleField,
  }) : super(key: key);

  late RegisterController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find<RegisterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Text('$titleField', style: TextStyle(fontSize: 14.0)),
        const SizedBox(height: 20.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Obx(
            () => TextFormField(
              obscureText: controller.isObsecure.value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(.2),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.toggleObsecure();
                  },
                  icon: controller.isObsecure.value
                      ? Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                ),
              ),
              onSaved: (String? value) {
                if (value!.isNotEmpty) controller.password = value;
              },
              validator: (String? value) {
                value!.isEmpty ? 'Please fill the name' : null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
