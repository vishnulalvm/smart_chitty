import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

Widget contactButton({
  IconData? icon,
  required String buttonName,
  void Function()? buttonAction,
}) {
  return InkWell(
    onTap: buttonAction,
    child: Container(
      alignment: Alignment.center,
      width: 180,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(1, 82, 136, 1),
              Color.fromRGBO(2, 199, 192, 1)
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1, 0.5),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          gap(width: 5),
          ModifiedText(text: buttonName, size: 14, color: Colors.white)
        ],
      ),
    ),
  );
}
