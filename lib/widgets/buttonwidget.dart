import 'package:flutter/material.dart';

Widget buttons(
    {required Function() buttonAction,
    required String buttonName,
    required Color color}) {
  return SizedBox(
    width: 250,
    height: 56,
    child: ElevatedButton(
      onPressed: buttonAction,
      autofocus: true,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
      ),
      child: Text(
        buttonName,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
