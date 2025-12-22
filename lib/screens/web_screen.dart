import 'package:auto_scroll_image/auto_scroll_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../core/ColorManager.dart';


class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {

  @override
  Widget build(BuildContext context) {
    double he=MediaQuery.of(context).size.height;
    double wi=MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Responsive logo size
    final double logoSize = isMobile ? wi * 0.2 : (isTablet ? wi * 0.15 : wi * 0.12);
    
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
      backgroundColor: Colors.transparent,
        body: SafeArea(
          child:CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 140,
                    ),
                    Text(
                      'We design and build',
                      style: GoogleFonts.albertSans(
                        fontSize: 18.sp,
                        //fontWeight: FontWeight.bold,
                        color: ColorManager.white,
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
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom Android apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom macOS apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.blue,
                              ),
                            ),
                            Text(
                              'Custom web apps',
                              style: GoogleFonts.albertSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
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
                    Text(
                      'Just with single Codebase',
                      style: GoogleFonts.albertSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.orange,
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? wi * 0.05 : (isTablet ? wi * 0.08 : wi * 0.1),
                      ),
                      child: Text(
                        'that give you and your customers the best experience possible',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.albertSans(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),



                    SizedBox(
                        width: wi * 0.3,
                        child: const AutoScrollImage()),
                    SizedBox(
                      height: 0.05.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Container(
                        width: wi ,
                        height: wi * 0.4,
                        decoration: const BoxDecoration(
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
          )
        ),
      ),
    );
  }
}
