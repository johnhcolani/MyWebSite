import 'package:flutter/material.dart';
import 'package:my_web_site/helper/sliding_menu.dart';
import 'package:my_web_site/screens/web_screen.dart';

import '../helper/app_background.dart';

import 'mobile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return const Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  AppBackground(),
                  MobileScreen(),
                  SlidingMenu(),

                ],
              ),
            );
          } else {
            return const Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  AppBackground(),
                  WebScreen(),
                  SlidingMenu(),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
