import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Timer(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ),
          ),
        );
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Theme.of(context).primaryColor,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/ud_logo.webp',
          width: screenSize.width * .75,
        ),
      ),
    );
  }
}
