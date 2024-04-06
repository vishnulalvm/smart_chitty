import 'package:flutter/material.dart';



class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.imagePath,
    required this.content,
  });

  final String imagePath;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1.1,
            height: MediaQuery.of(context).size.height * .6,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Text(
    content,
    style: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
        ],
      ),
    );
  }
}
