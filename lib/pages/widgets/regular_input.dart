import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugasminggu6/controllers/register_controller.dart';

class RegularInputField extends StatelessWidget {
  late String titleField;
  RegularInputField({
    Key? key,
    required this.titleField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.find<RegisterController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Text('$titleField', style: TextStyle(fontSize: 14.0)),
        const SizedBox(height: 20.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(.2),
              border: InputBorder.none,
            ),
            onSaved: (String? value) {
              if (value!.isNotEmpty)
                (titleField == 'Name')
                    ? controller.name = value
                    : controller.email = value;
            },
            validator: (String? value) {
              value!.isEmpty ? 'Please fill the name' : null;
            },
          ),
        ),
      ],
    );
  }
}
