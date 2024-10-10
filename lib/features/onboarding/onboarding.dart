import 'dart:developer';

import 'package:assist/common_widgets/common_button.dart';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final homeCon = Get.put<HomeController>(HomeController());
  final pageCon = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    homeCon.dispose();
    pageCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Stack(
            children: [
              PageView.builder(
                itemCount: homeCon.demoData.length,
                controller: pageCon,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  homeCon.currentPage.value = index;
                  log("Current Page: ${homeCon.currentPage.value}");
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: size.height * 0.10),
                      SvgPicture.asset(homeCon.demoData[index].imageUrl,
                          height: size.height * 0.30),
                      SizedBox(height: size.height * 0.05),
                      Text(
                        homeCon.demoData[index].title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: size.height * 0.05),
                      Text(
                        homeCon.demoData[index].description,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                    ],
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Expanded(
                        flex: 2,
                        child: homeCon.currentPage.value == 2
                            ? CommonButton(
                                text: "Continue",
                                onPressed: () async {
                                  Get.toNamed('/welcome');
                                },
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: size.width * 0.10,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            homeCon.demoData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 5,
                              width: homeCon.currentPage.value == index
                                  ? 15
                                  : 5, // Adjust the size of the active dot
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: homeCon.currentPage.value == index
                                    ? primaryColor
                                    : Colors
                                        .grey, // Adjust active and inactive dot colors
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.topRight,
                  child: homeCon.currentPage.value == 2
                      ? Container()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: primaryColor,
                            elevation: 0,
                          ),
                          onPressed: () async {
                            // Handle skip button press
                            await pageCon.animateToPage(2,
                                duration: const Duration(seconds: 1),
                                curve: Curves.decelerate);
                          },
                          child: const Text("Skip")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
