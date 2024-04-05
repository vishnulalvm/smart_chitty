import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  required void Function(int)? onpresed,
  String item1 = '',
  String item2 = '',
  bool showMenu = true,
}) {
  return AppBar(
    actions: [
      showMenu ?
      PopupMenuButton<int>(
        onSelected: onpresed,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            value: 1,
            child: Text(item1),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text(item2),
          ),
        ],
      ):const SizedBox(),
    ],
    title: Text(
      title,
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(1, 82, 136, 1),
              Color.fromRGBO(2, 199, 192, 1)
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1, 0.5),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),
    // Add other AppBar properties here
  );
}
