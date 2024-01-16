import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/menu_item.dart';
import 'package:sizer/sizer.dart';

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
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      left: wi < 500
          ? (isSlideOpen ? wi * 0.15 : wi - 35)
          : (isSlideOpen ? wi * 0.73 : wi - 35),
      duration: const Duration(milliseconds: 700),
      child: Row(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: Container(
                height: he,
                width: wi < 500 ? wi - 100 : wi / 4,
                color: const Color(0xFF4B556E).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                         child: Column(
                          children: [
                            const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png')),
                             Text('4iDeas',style: TextStyle(fontSize: wi<500 ? 13.sp : 8.sp,color: Colors.orange),),
                            Text(
                              "Let's Talk! 🇺🇸\n(804)774-0257",
                              style: TextStyle(fontSize:  wi<500 ? 13.sp : 8.sp, color: ColorManager.white),textAlign: TextAlign.center,
                            ),
                          ],
                                               ),
                       ),
                      Divider(
                        height: 20,
                        color: Colors.white.withOpacity(0.4),
                        indent: 32,
                        endIndent: 32,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            MenuItem(icon: Icons.design_services, title: 'Services'),
                            MenuItem(icon: Icons.people, title: 'About Us'),
                            MenuItem(icon: Icons.note, title: 'Portfolio'),
                            MenuItem(icon: Icons.contrast, title: 'Order Here'),
                            MenuItem(
                                icon: Icons.connect_without_contact, title: 'Contact Us'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: const Color(0xFF4B556E),
            width: wi>500 ? wi*0.005 : wi*0.01,
            height: he,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSlideOpen = !isSlideOpen;
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
                    icon: !isSlideOpen
                        ? AnimatedIcons.menu_close
                        : AnimatedIcons.close_menu,
                    progress: _animationController.view,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(width, 0);
    path.quadraticBezierTo(width, 8, width - 10, 16);
    path.quadraticBezierTo(0, width, 0, height / 2);
    path.quadraticBezierTo(0, height - width, width - 10, height - 16);
    path.quadraticBezierTo(width, height - 8, width, height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
