import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  void Function()? onpresed
  
}) {
  return AppBar(
    actions: [
      IconButton(onPressed: onpresed, icon: const Icon(Icons.more_vert))
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
