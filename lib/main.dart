import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'DU Truck Booking',
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(colorPimaryHex),
        appBarTheme: const AppBarTheme(color: Color(colorPimaryHex)),
        scaffoldBackgroundColor: Colors.white,
        toggleableActiveColor: const Color(colorPimaryHex),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color(colorPimaryHex),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(colorPimaryHex),
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
