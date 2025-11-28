import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/screens/auth/login_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;
  List<Widget> get pageviewchildren => [
    onBoardingContent(
      image: 'assets/images/shopping.png',
      title: 'Shop Everything You Need',
      subtitle:
          'From electronics to fashion, explore millions of products in one place.',
    ),
    onBoardingContent(
      image: 'assets/images/payments.png',
      title: 'Safe & Easy Checkout',
      subtitle:
          'Pay confidently with secure transactions and multiple payment options.',
    ),
    onBoardingContent(
      image: 'assets/images/delivery.png',
      title: 'Track & Receive Quickly',
      subtitle: 'Real‑time tracking and doorstep delivery at lightning speed.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 60,
                child: ButtonComponent(
                  ontap: () {
                    callNextScreenAndClearStack(context, LoginScreen());
                  },
                  buttontitle: 'skip',
                  bgcolor: AppColors.primarycolor,
                ),
              ).withPadding(padding: EdgeInsets.symmetric(horizontal: 20)),
            ),
            Expanded(
              child: PageView(
                controller: _pageViewController,
                onPageChanged: _handlePageViewChanged,
                children: pageviewchildren,
              ),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _currentPageIndex == 0 ? 0 : 1,
                  child: SizedBox(
                    width: 80,
                    child: ButtonComponent(
                      ontap: () {
                        if (_currentPageIndex > 0) {
                          _updateCurrentPageIndex(_currentPageIndex - 1);
                        }
                      },
                      buttontitle: 'previous',
                      bgcolor: AppColors.greywithshade.withOpacity(0.2),
                    ),
                  ),
                ),
                Indicator(
                  length: pageviewchildren.length,
                  currentIndex: _currentPageIndex,
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _currentPageIndex == pageviewchildren.length - 1
                      ? 0
                      : 1,
                  child: SizedBox(
                    width: 60,
                    child: ButtonComponent(
                      ontap: () {
                        if (_currentPageIndex < pageviewchildren.length - 1) {
                          _updateCurrentPageIndex(_currentPageIndex + 1);
                        }
                      },
                      buttontitle: 'next',
                    ),
                  ),
                ),
              ],
            ).withPadding(padding: EdgeInsets.symmetric(horizontal: 20)),
          ],
        ),
      ),
    );
  }

  Widget onBoardingContent({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: Appfonts.robotobold,
                  color: AppColors.primarycolor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.greywithshade,
                  fontFamily: Appfonts.robotobold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget Indicator({required int length, required int currentIndex}) {
    return Row(
      children: List.generate(length, (index) {
        return Padding(
          padding: EdgeInsets.all(AppPadding.xs),
          child: AnimatedContainer(
            curve: Curves.easeInCirc,
            duration: Duration(milliseconds: 200),
            height: currentIndex == index ? 15 : 10,
            width: currentIndex == index ? 15 : 10,
            decoration: BoxDecoration(
              borderRadius: .circular(AppRadius.circle),
              color: currentIndex == index
                  ? AppColors.primarycolor
                  : AppColors.greywithshade.withOpacity(0.5),
            ),
          ),
        );
      }),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
