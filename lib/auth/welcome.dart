import 'package:flutter/material.dart';
import 'package:smart_chitty/widgets/features/continue_button.dart';
import 'package:smart_chitty/widgets/features/image_view.dart';
import 'package:smart_chitty/widgets/features/skip_button.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ImageView(imagePath: "lib/assets/1c.jpg", content: "Home Page"),
            ImageView(imagePath: "lib/assets/2c.jpg", content: "Add Transaction Page"),
            ImageView(imagePath: "lib/assets/3c.jpg", content: "Transaction History Page"),
            ImageView(imagePath: "lib/assets/6c.jpg", content: "Master your money. Good luck"),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.06, // Adjust according to your layout
          left: 20,
          child: Row(
            children: [
              Text(
                'Page ${_currentPage + 1}/4', // Display the current page number
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SkipButton(pageController: _pageController),
        ContinueButton(currentPage: _currentPage, pageController: _pageController),
      ],
    ));
  }
}