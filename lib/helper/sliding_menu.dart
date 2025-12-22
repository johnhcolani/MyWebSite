import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/menu_item.dart';
import 'package:my_web_site/screens/about_us_screen.dart';
import 'package:my_web_site/screens/dart_programing_course/dart_programing.dart';
import 'package:my_web_site/screens/order_here_screen.dart';
import 'package:my_web_site/screens/portfolio_screen.dart';
import 'package:my_web_site/screens/services_screen.dart';
import 'package:sizer/sizer.dart';

import 'alert_dialog_data.dart';


class SlidingMenu extends StatefulWidget {
  const SlidingMenu({super.key});

  @override
  State<SlidingMenu> createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu>
    with SingleTickerProviderStateMixin {
  bool isSlideOpen = false;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Calculate drawer width responsively
    double drawerWidth;
    if (isMobile) {
      drawerWidth = wi * 0.75; // 75% of screen on mobile
    } else if (isTablet) {
      drawerWidth = 320; // Fixed 320px on tablet
    } else {
      drawerWidth = 350; // Fixed 350px on desktop (wider than before)
    }
    
    // Calculate drawer position - now on left side
    double closedPosition = -drawerWidth; // Hidden on the left
    double openPosition = 0; // Fully visible on the left

    return Stack(
      children: [
        // Drawer content
        AnimatedPositioned(
          left: isSlideOpen ? openPosition : closedPosition,
          duration: _animationController.duration ?? const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2D3748),
                      const Color(0xFF1A202C),
                    ],
                  ),
                ),
                width: isMobile ? 2 : 3,
                height: he,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMobile ? 20 : 24),
                  bottomLeft: Radius.circular(isMobile ? 20 : 24),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: he,
                    width: drawerWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF4B556E).withValues(alpha: 0.4),
                          const Color(0xFF2D3748).withValues(alpha: 0.5),
                        ],
                      ),
                      border: Border(
                        right: BorderSide(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(5, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 14.0 : 16.0),
                      child: Column(
                        children: [
                      SizedBox(
                        height: isMobile ? 2.h : 3.h,
                      ),
                      // Header Section with better styling
                      Container(
                        padding: EdgeInsets.all(isMobile ? 14 : 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.orange.withValues(alpha: 0.5),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: isMobile ? 35 : 38,
                                backgroundImage:
                                    const AssetImage('assets/images/logo.png'),
                              ),
                            ),
                            SizedBox(height: isMobile ? 12 : 14),
                            Text(
                              '4iDeas',
                              style: TextStyle(
                                fontSize: isMobile ? 22 : (isTablet ? 20 : 18),
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orange,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: isMobile ? 12 : 14),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 14,
                                vertical: isMobile ? 10 : 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorManager.blue.withValues(alpha: 0.15),
                                    ColorManager.orange.withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Let's Talk! 🇺🇸",
                                    style: TextStyle(
                                      fontSize: isMobile ? 14 : (isTablet ? 13 : 12),
                                      color: ColorManager.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "804-774-9008",
                                    style: TextStyle(
                                      fontSize: isMobile ? 18 : (isTablet ? 17 : 16),
                                      color: ColorManager.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 24),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 4.0 : 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            MenuItem(
                              icon: Icons.design_services,
                              title: 'Services',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ServicesScreen()));
                              },
                            ),
                            MenuItem(
                              icon: Icons.people,
                              title: 'About Us',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUsScreen()));
                              },
                            ),
                            MenuItem(
                              icon: Icons.note,
                              title: 'Portfolio',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PortfolioScreen()));
                              },
                            ),
                            MenuItem(
                              icon: Icons.contrast,
                              title: 'Order Here',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderHereScreen()));
                              },
                            ),
                            MenuItem(
                              icon: Icons.note,
                              title: 'Dart programming',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DartPrograming()));
                              },
                            ),
                            MenuItem(
                              icon: Icons.connect_without_contact,
                              title: 'Contact Us',
                              onPressed: () {
                                // Show a dialog when the button is pressed
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialogData(wi: wi , he: he,);
                                  },
                                );
                              },
                            ),
                              ],
                            ),
                          ),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Menu button - moves with drawer, stays at right edge of drawer when open
        AnimatedPositioned(
          duration: _animationController.duration ?? const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          left: isSlideOpen ? drawerWidth + 3 : 0,
          top: (he / 2) - 55,
          child: InkWell(
            onTap: () {
              setState(() {
                isSlideOpen = !isSlideOpen;
                if (isSlideOpen) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            child: Align(
              alignment: const Alignment(0, -0.5),
              child: ClipPath(
                clipper: CustomMenuClipper(),
                child: Container(
                  width: 35,
                  height: 110,
                  color: const Color(0xFF4B556E),
                  alignment: Alignment.center,
                  child: AnimatedIcon(
                    color: ColorManager.white,
                    size: 25,
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController.view,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    // Clipping from left side now (mirrored)
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width, width, width, height / 2);
    path.quadraticBezierTo(width, height - width, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}