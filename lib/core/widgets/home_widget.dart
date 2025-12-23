import 'package:auto_scroll_image/auto_scroll_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../ColorManager.dart';


class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.he,
    required this.wi,
  });

  final double he;
  final double wi;

  @override
  Widget build(BuildContext context) {
    // Responsive breakpoints
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Responsive logo size
    final double logoSize = isMobile ? wi * 0.2 : (isTablet ? wi * 0.15 : wi * 0.12);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: wi < 600 ? 140 : (wi < 1024 ? 160 : 180),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: wi * 0.05),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow effect behind text
                          // Text(
                          //   'We design and build',
                          //   textAlign: TextAlign.center,
                          //   style: GoogleFonts.albertSans(
                          //     fontSize: 24.sp,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.transparent,
                          //     shadows: [
                          //       Shadow(
                          //         color: ColorManager.white.withValues(alpha: 0.15),
                          //         blurRadius: 20,
                          //         offset: Offset(0, 0),
                          //       ),
                          //       Shadow(
                          //         color: ColorManager.blue.withValues(alpha: 0.1),
                          //         blurRadius: 30,
                          //         offset: Offset(0, 0),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Main glass text with realistic liquid glass effect
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background glow
                              Text(
                                'We design and build',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.albertSans(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                      color: ColorManager.blue.withValues(alpha: 0.4),
                                      blurRadius: 30,
                                      offset: Offset(0, 0),
                                    ),
                                    Shadow(
                                      color: ColorManager.white.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              // Liquid glass effect with multiple layers
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  final bool isMobile = wi < 600;
                                  return LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      // Top highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.95 : 0.85),
                                      // Bright center
                                      Colors.white.withValues(alpha: isMobile ? 0.75 : 0.65),
                                      // Mid tone
                                      Colors.white.withValues(alpha: isMobile ? 0.45 : 0.35),
                                      // Darker mid
                                      Colors.white.withValues(alpha: isMobile ? 0.35 : 0.25),
                                      // Bottom highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.65 : 0.55),
                                      // Edge highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.85 : 0.75),
                                    ],
                                    stops: [0.0, 0.15, 0.4, 0.6, 0.8, 1.0],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'We design and build',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.albertSans(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      // Inner highlight (top)
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        blurRadius: 2,
                                        offset: Offset(0, -2),
                                      ),
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        blurRadius: 4,
                                        offset: Offset(0, -1),
                                      ),
                                      // Inner shadow (bottom)
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.6),
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                      // Depth shadow
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                      // Soft depth
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.4),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                      // Outer glow
                                      Shadow(
                                        color: ColorManager.blue.withValues(alpha: 0.4),
                                        blurRadius: 15,
                                        offset: Offset(0, 0),
                                      ),
                                      Shadow(
                                        color: ColorManager.white.withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 0),
                                      ),
                                      // Extended glow
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        blurRadius: 25,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Top highlight reflection
                              Positioned(
                                top: -5,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withValues(alpha: 0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Custom iOS apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 13.sp,
                               // fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom Android apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 13.sp,
                               // fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom macOS apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 13.sp,
                               // fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom web apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 13.sp,
                                // fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: wi * 0.05),
                        Container(
                          width: logoSize,
                          height: logoSize,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/image_7.png'),
                              fit: BoxFit.contain
                            )
                          ),
                        ),
                      ],
                    ),
                    Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background glow
                              Text(
                                'With single Codebase',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.albertSans(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                      color: ColorManager.blue.withValues(alpha: 0.4),
                                      blurRadius: 30,
                                      offset: Offset(0, 0),
                                    ),
                                    Shadow(
                                      color: ColorManager.white.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              // Liquid glass effect with multiple layers
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  final bool isMobile = wi < 600;
                                  return LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      // Top highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.95 : 0.85),
                                      // Bright center
                                      Colors.white.withValues(alpha: isMobile ? 0.75 : 0.65),
                                      // Mid tone
                                      Colors.white.withValues(alpha: isMobile ? 0.45 : 0.35),
                                      // Darker mid
                                      Colors.white.withValues(alpha: isMobile ? 0.35 : 0.25),
                                      // Bottom highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.65 : 0.55),
                                      // Edge highlight
                                      Colors.white.withValues(alpha: isMobile ? 0.85 : 0.75),
                                    ],
                                    stops: [0.0, 0.15, 0.4, 0.6, 0.8, 1.0],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'With single Codebase',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.albertSans(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      // Inner highlight (top)
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        blurRadius: 2,
                                        offset: Offset(0, -2),
                                      ),
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        blurRadius: 4,
                                        offset: Offset(0, -1),
                                      ),
                                      // Inner shadow (bottom)
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.6),
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                      // Depth shadow
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                      // Soft depth
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.4),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                      // Outer glow
                                      Shadow(
                                        color: ColorManager.blue.withValues(alpha: 0.4),
                                        blurRadius: 15,
                                        offset: Offset(0, 0),
                                      ),
                                      Shadow(
                                        color: ColorManager.white.withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 0),
                                      ),
                                      // Extended glow
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        blurRadius: 25,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Top highlight reflection
                              Positioned(
                                top: -5,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withValues(alpha: 0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    // Text(
                    //   'Just with single Codebase',
                    //   style: GoogleFonts.albertSans(
                        
                    //     fontSize: 15.sp,
                    //     fontWeight: FontWeight.bold,
                    //     color: ColorManager.orange,
                    //   ),
                      
                    // ),
                    SizedBox(
                      height: he * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? wi * 0.05 : (isTablet ? wi * 0.08 : wi * 0.1),
                      ),
                      child: Text(
                        'that give you and your customers the best experience possible',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.chilanka(
                          fontSize: 18.sp,
                          //fontWeight: FontWeight.bold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoScrollImage(


                    ),

                    SizedBox(
                      height: he * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: wi ,
                        height: wi * 0.3,
                        decoration: const BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white,
                          //     spreadRadius: 0,
                          //     blurRadius: 5,
                          //     offset: Offset(0,0),
                          //   )
                          // ],
                            image: DecorationImage(
                                image: AssetImage('assets/images/top-web-apps.png'),
                                fit: BoxFit.contain
                            )
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),

                  ],
                ),
              )
            ],

          ),
        ),
      ),
    );
  }

}