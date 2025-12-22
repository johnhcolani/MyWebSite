import 'package:flutter/material.dart';
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/sliding_menu.dart';
import 'package:my_web_site/screens/web_screen.dart';
import 'package:sizer/sizer.dart';

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
    double wi = MediaQuery.of(context).size.width;
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return Stack(
              children: [
                const AppBackground(),
                const MobileScreen(),
                // Transparent container at top like appbar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: _buildTopContainer(isMobile, isTablet, wi),
                  ),
                ),
                const SlidingMenu(),
              ],
            );
          } else {
            return Stack(
              children: [
                const AppBackground(),
                const WebScreen(),
                // Transparent container at top like appbar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: _buildTopContainer(isMobile, isTablet, wi),
                  ),
                ),
                const SlidingMenu(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTopContainer(bool isMobile, bool isTablet, double wi) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : (isTablet ? 24.0 : 32.0),
        vertical: isMobile ? 20.0 : (isTablet ? 24.0 : 28.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? wi * 0.12 : (isTablet ? wi * 0.08 : wi * 0.08),
                height: isMobile ? wi * 0.12 : (isTablet ? wi * 0.08 : wi * 0.08),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Text(
                '4iDeas',
                style: TextStyle(
                  fontSize: isMobile ? 16.sp : (wi > 500 ? 11.sp : 16.sp),
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on,
                color: ColorManager.blue,
                size: isMobile ? wi * 0.04 : (isTablet ? wi * 0.02 : wi * 0.02),
              ),
              SizedBox(width: isMobile ? 6 : 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Based in ',
                      style: TextStyle(
                        fontSize: isMobile ? 10 : (isTablet ? 6.sp : 6.sp),
                        color: ColorManager.orange,
                      ),
                    ),
                    TextSpan(
                      text: 'Richmond, VA ',
                      style: TextStyle(
                        fontSize: isMobile ? 10 : (isTablet ? 6.sp : 6.sp),
                        fontWeight: FontWeight.bold,
                        color: ColorManager.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
