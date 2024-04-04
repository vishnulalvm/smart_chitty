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
      child: Container(
        width: 380,
        height: 480,
        decoration: BoxDecoration(
          color: Color(0XFF9486F7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 15,
              blurStyle: BlurStyle.outer,
              spreadRadius: .2,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              content,
              
            ),
          ],
        ),
      ),
    );
  }
}