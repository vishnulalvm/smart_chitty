import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height *
          0.12, // Adjust according to your layout
      right: 20,
      child: TextButton(
        onPressed: () {
          _pageController.jumpToPage(3); // Skip to the last page
        },
        child: const Text(
          'Skip',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
