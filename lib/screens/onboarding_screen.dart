import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccerably/const.dart';
import 'package:soccerably/controller/onboard_provider.dart';

class Onboarding extends StatefulWidget {
  Onboarding({
    super.key,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: provider.pageController,
                  onPageChanged: (value) {
                    provider.pageIndex(value);
                  },
                  itemCount: provider.onboardingPages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 320,
                          width: 240,
                          child: Image.asset(
                            provider.onboardingPages[index].image,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 64.0),
                          child: Text(
                            provider.onboardingPages[index].descript,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      provider.skip(context);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: redColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                          provider.onboardingPages.length,
                          (index) => Container(
                                margin: const EdgeInsets.all(4),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: provider.selectedPageIndex == index
                                      ? redColor
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ))
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        provider.selectedPageIndex == 2
                            ? provider.skip(context)
                            : provider.forwardAction();
                      },
                      child: provider.selectedPageIndex == 2
                          ? const Text(
                              "Start",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: redColor),
                            )
                          : const Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: redColor),
                            )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
