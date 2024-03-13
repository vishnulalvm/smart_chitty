import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  final double? theWidth;
  final double? theHeight;
  final Widget? theChild;
  const FrostedGlassBox(
      {super.key,
      required this.theWidth,
      required this.theHeight,
      required this.theChild});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
       
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //blur effect ==> the third layer of stack
              BackdropFilter(
                filter: ImageFilter.blur(
                  //sigmaX is the Horizontal blur
                  sigmaX: 4.0,
                  //sigmaY is the Vertical blur
                  sigmaY: 4.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                ),
              ),
              //gradient effect ==> the second layer of stack
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black.withOpacity(0.13)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //begin color
                        Colors.black.withOpacity(0.15),
                        //end color
                        Colors.black.withOpacity(0.05),
                      ]),
                ),
                
              ),
              Positioned(
                // top: 0,
                // bottom: 0,
                // left: 140,
                // right: 0,
                child: theChild!)
               
            ],
          ),
        ),
      ),
    );
  }
}
