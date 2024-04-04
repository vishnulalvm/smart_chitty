import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';

class StepperContent extends StatelessWidget {
  final String imagePath;
  final String text;
  const StepperContent({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
          ModifiedText(text: text, size: 16, color: AppColor.fontColor)
        ],
      ),
    );
  }
}
