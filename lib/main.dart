import 'package:flutter/material.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.deepPurple;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Natalis Base',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarySeedColor),
        primaryColor: primarySeedColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      routes: {},
    );
  }
}