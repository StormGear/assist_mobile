import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const MovingBackgroundScreen();
  }
}

class MovingBackgroundScreen extends StatefulWidget {
  const MovingBackgroundScreen({super.key});

  @override
  MovingBackgroundScreenState createState() => MovingBackgroundScreenState();
}

class MovingBackgroundScreenState extends State<MovingBackgroundScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _images = [
    'assets/images/onboarding/carpenter.png',
    'assets/images/onboarding/electrician.jpg',
    'assets/images/onboarding/plumber.jpg',
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage != _images.length - 1) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
        _currentPage++;
      } else {
        _pageController.jumpToPage(
          0,
        );
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(color: Colors.white),
          // Background Image Slider
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }

                    return Center(
                      child: Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
          Container(),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Foreground buttons
          Positioned(
            top: size.height * 0.1,
            left: size.width * 0.3,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.1,
            left: size.width * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/signin');
                    },
                    child: const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.5,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
