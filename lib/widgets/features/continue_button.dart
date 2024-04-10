import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';


class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required int currentPage,
    required PageController pageController,
  })  : _currentPage = currentPage,
        _pageController = pageController;

  final int _currentPage;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.blue,
              ),
              child: const Icon(
                Symbols.arrow_back_ios,
                size: 28,
                weight: 800,
                color: Colors.white,
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (_currentPage < 3) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else {
                // Navigate to the next screen when on the last page
                context.pushReplacement('/splash');
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              backgroundColor: Colors.blue,
            ),
            child: const Icon(
              Symbols.arrow_forward_ios,
              size: 28,
              weight: 800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
//  child: Text(_currentPage < 3 ? 'Continue' : 'Finish'),

  
            