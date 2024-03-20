import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';

Widget customTextField({
  required var hintText,
  required var title,
   TextEditingController? controller,
  Key? key,
  required String? Function(String?)? validator,
  TextInputType? keyboardtype, required TextInputType keyboardType,
}) {
  return Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    
    children: [
      ModifiedText(text: title, size: 14, color: AppColor.fontColor,fontWeight: FontWeight.w500,),
     gap(width: 50),
      SizedBox(
        width: 200,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardtype,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black54,fontSize: 14),
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
