import 'package:flutter/material.dart';

Widget textField({
  bool obscureText=false,
  required var hintText,
  required IconData icons,
  required TextEditingController controller,
  Key? key,
  required String? Function(String?)? validator,
  TextInputType? keyboardtype,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icons),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardtype,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.white, // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Rounded border
                borderSide: BorderSide.none, // No border side
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Rounded border
                borderSide:
                    const BorderSide(color: Colors.blue), // Border color
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
