import 'package:flutter/material.dart';
import 'package:smart_chitty/widgets/features/continue_button.dart';
import 'package:smart_chitty/widgets/features/image_view.dart';
import 'package:smart_chitty/widgets/features/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                ImageView(
                    imagePath: "assets/images/business.jpg",
                    content: "Unlock Greater Financial\nFlexibility"),
                ImageView(
                    imagePath: "assets/images/invest.jpg",
                    content: "User-Friendly Platform"),
                ImageView(
                    imagePath: "assets/images/groth.jpg",
                    content: "Scale Up Your\nBusiness"),
                ImageView(
                    imagePath: "assets/images/analist.jpg",
                    content: "Analyze Your Statistics"),
              ],
            ),
            SkipButton(pageController: _pageController),
            ContinueButton(
                currentPage: _currentPage, pageController: _pageController),
          ],
        ));
  }
}
