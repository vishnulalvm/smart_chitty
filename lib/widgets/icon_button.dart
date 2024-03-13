import 'package:flutter/material.dart';

class CircularIconhome extends StatelessWidget {
  final IconData icontype;
  final String iconname;
  final void Function() buttonpress;

  const CircularIconhome(
      {super.key, required this.icontype, required this.buttonpress, required this.iconname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: buttonpress,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
            backgroundColor: Colors.blue,
          ),
          child: Icon(
            icontype,
            size: 28,
            weight: 800,
            color: Colors.white,
            
          ),
        ),
        const SizedBox(height: 12,),
        Text(iconname,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
      ],
    );
  }
}
