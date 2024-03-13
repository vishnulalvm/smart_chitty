import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';

Widget customListTile(
    {required void Function()? onTap,
    required String title,
    required IconData leading}) {
  return ListTile(
    onTap: onTap,
    title: ModifiedText(
      text: title,
      size: 16,
      color: AppColor.fontColor,
      fontWeight: FontWeight.w500,
    ),
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 22,
      child: Icon(
        leading,
        size: 24,
        color: Colors.white,
      ),
    ),
    trailing: const Icon(
      Icons.chevron_right,
      color: Colors.black,
      size: 24,
    ),
  );
}
