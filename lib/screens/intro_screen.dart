import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:ud_truck_booking/screens/login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late ThemeData _theme;
  late Size _screenSize;

  final _slides = <Slide>[];

  bool _isInit = true;

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];

    for (int i = 0; i < _slides.length; i++) {
      Slide currentSlide = _slides[i];
      tabs.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              currentSlide.pathImage!,
              height: _screenSize.width * .9,
              fit: BoxFit.contain,
            ),
            Container(
              child: Text(
                currentSlide.title!,
                style: currentSlide.styleTitle,
                textAlign: TextAlign.center,
              ),
              margin: const EdgeInsets.only(top: 32.0),
            ),
            Container(
              child: Text(
                currentSlide.description!,
                style: currentSlide.styleDescription,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              margin: const EdgeInsets.only(top: 8.0),
            ),
          ],
        ),
      );
    }

    return tabs;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _theme = Theme.of(context);
      _screenSize = MediaQuery.of(context).size;
      _isInit = false;

      _slides.add(
        _generateSlide('assets/images/intro/first.webp', 'Booking Service',
            'Kendaraanmu Sekarang'),
      );
      _slides.add(
        _generateSlide('assets/images/intro/second.webp',
            'Dapatkan Banyak Kemudahan', 'Di Bengkel Kami'),
      );
      _slides.add(
        _generateSlide('assets/images/intro/third.webp',
            'Kumpulkan Pointnya dan dapatkan', 'Berbagai Keuntungan nya'),
      );
    }

    super.didChangeDependencies();
  }

  Slide _generateSlide(String image, String title, String description) {
    return Slide(
      pathImage: image,
      title: title,
      styleTitle: TextStyle(
          color: _theme.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      description: description,
      styleDescription: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroSlider(
          renderSkipBtn: const Text('Lewati'),
          renderNextBtn: const Text('Lanjut'),
          renderDoneBtn: const Text('Mulai'),
          colorDot: Colors.grey[300],
          colorActiveDot: _theme.primaryColor,
          sizeDot: 13.0,
          listCustomTabs: renderListCustomTabs(),
          scrollPhysics: const BouncingScrollPhysics(),
          onDonePress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
