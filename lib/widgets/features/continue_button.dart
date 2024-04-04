import 'package:flutter/material.dart';
import 'package:smart_chitty/auth/splash.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required int currentPage,
    required PageController pageController,
  }) : _currentPage = currentPage, _pageController = pageController;

  final int _currentPage;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height *
          0.12, 
      right: MediaQuery.of(context).size.width *
          0.05,
      left:  MediaQuery.of(context).size.width *
          0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color(0XFF9486F7)),
              ),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: const Text('Previous'),
            ),
          ElevatedButton(
            // style: ButtonStyle(
            //   backgroundColor: Colors.blue,
            // ),
            onPressed: () {
              if (_currentPage < 3) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else {
                // Navigate to the next screen when on the last page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
              }
            },
            child: Text(_currentPage < 3 ? 'Continue' : 'Finish'),
          ),
        ],
      ),
    );
  }
}