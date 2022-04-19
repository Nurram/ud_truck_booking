import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/colors.dart';
import 'package:ud_truck_booking/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DU Truck Booking',
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(colorPimaryHex),
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color(colorPimaryHex),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: const Color(colorPimaryHex),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
