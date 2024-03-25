import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';

Widget rowText({required String firstText, required String secoundText}) {
  return Padding(
    padding: const EdgeInsets.only(left: 36, right: 36, top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ModifiedText(text: firstText, size: 18, color: AppColor.fontColor,fontWeight: FontWeight.w500),
        ModifiedText(text: secoundText, size: 18, color: AppColor.fontColor,fontWeight: FontWeight.w500)
      ],
    ),
  );
}
