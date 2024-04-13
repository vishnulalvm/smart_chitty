import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class ScrollingText extends StatefulWidget {
  final String text;

  const ScrollingText({super.key, required this.text});

  @override
  ScrollingTextState createState() => ScrollingTextState();
}

class ScrollingTextState extends State<ScrollingText> {
  @override
  Widget build(BuildContext context) {
    return TextScroll(
      fadeBorderSide: FadeBorderSide.both,
      widget.text,
      mode: TextScrollMode.endless,
      velocity: const Velocity(pixelsPerSecond: Offset(70, 0)),
      delayBefore: const Duration(milliseconds: 100),
      numberOfReps: 1000,
      pauseBetween: const Duration(seconds: 1),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.right,
      selectable: true,
    );
  }
}
