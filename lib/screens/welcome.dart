import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:natalis_frontend/screens/doctor_login.dart';
import 'package:natalis_frontend/screens/homescreen.dart'; // 1. Import the HomeScreen
import '../widgets/image.dart';
import '../widgets/long_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  AppImage(
                    imagePath: 'assets/natalis-logo.png',
                    width: 180,
                    height: 180,
                  ),
                  SizedBox(height: 48),
                  Text(
                    "Welcome To Natalis!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "AI powered Prenatal Ultrasound Screening",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  LongButton(
                    text: "Get Started",
                    logo: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 16,
                    ),
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
                      color: Theme
                          .of(context)
                          .primaryColor,
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
                    textColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  const SizedBox(height: 16),
                  LongButton(
                    logo: FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Theme
                          .of(context)
                          .primaryColor,
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
                    textColor: Theme
                        .of(context)
                        .primaryColor,
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