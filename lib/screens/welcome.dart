import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:natalis_frontend/screens/doctor_login.dart';
import 'package:natalis_frontend/screens/homescreen.dart'; // 1. Import the HomeScreen
import '../widgets/image.dart';
import '../widgets/long_button.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_IntroPage> introPages = [
    _IntroPage(
      animationPath: 'assets/home_screen_animation.json',
      title: 'Welcome to Natalis',
      subtitle:
          'An intelligent platform for accurate prenatal ultrasound assessment.',
    ),

    _IntroPage(
      animationPath: 'assets/baby_animation.json',
      title: 'Precise Gestational Age',
      subtitle:
          'Calculate gestational age using advanced ultrasound measurements.',
    ),

    _IntroPage(
      animationPath: 'assets/report_animation.json',
      title: 'Clinical Insights',
      subtitle: 'Generate structured reports with automated prenatal analysis.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // AppImage(
                  //   imagePath: 'assets/natalis-logo.png',
                  //   width: 180,
                  //   height: 180,
                  // ),
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: introPages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final page = introPages[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(page.animationPath, height: 180),
                            const SizedBox(height: 16),
                            Text(
                              page.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                page.subtitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 48),
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      introPages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 12 : 8,
                        height: _currentIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  // Text(
                  //   "Welcome To Natalis!",
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(height: 8),
                  // Text(
                  //   "AI powered Prenatal Ultrasound Screening",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.normal,
                  //     color: Colors.black54,
                  //   ),
                  // ),
                ],
              ),
              Column(
                children: [
                  LongButton(
                    text: "Get Started",
                    logo: const FaIcon(FontAwesomeIcons.arrowRight, size: 16),
                    logoOnLeft: false,
                    onPressed: () {
                      print("Get Started button pressed!");
                      // TODO: Add navigation for Get Started
                    },
                  ),
                  const SizedBox(height: 16),
                  LongButton(
                    logo: FaIcon(
                      FontAwesomeIcons.userDoctor,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    text: "Doctor Login",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorLoginScreen(),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  LongButton(
                    logo: FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    text: "Patient Login",
                    onPressed: () {
                      // 2. Add navigation to the HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroPage {
  final String animationPath;
  final String title;
  final String subtitle;

  _IntroPage({
    required this.animationPath,
    required this.title,
    required this.subtitle,
  });
}
