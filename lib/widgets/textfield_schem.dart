import 'package:flutter/material.dart';

Widget customTextField({
  required var hintText,
  required var title,
   TextEditingController? controller,
  Key? key,
  required String? Function(String?)? validator,
  TextInputType? keyboardtype, required TextInputType keyboardType,
}) {
  return Row(
    children: [
      Text(title),
      SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 250,
        child: TextFormField(
          keyboardType: keyboardtype,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          validator: validator,
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
              borderSide: const BorderSide(color: Colors.blue), // Border color
            ),
          ),
        ),
      ),
    ],
  );
}
