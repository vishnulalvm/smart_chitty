import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

Widget customTextField({
  var maxline,
  required BuildContext context,
  required var hintText,
  required var title,
  TextEditingController? controller,
  Key? key,
  required String? Function(String?)? validator,
  TextInputType? keyboardtype,
  required TextInputType keyboardType,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ModifiedText(
        text: title,
        size: 14,
        color: AppColor.fontColor,
        fontWeight: FontWeight.w500,
      ),
      gap(
        width: MediaQuery.of(context).size.height * 0.03,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.height * 0.23,
        child: TextFormField(
          maxLines: maxline,
          controller: controller,
          keyboardType: keyboardtype,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          // autofocus: false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
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
