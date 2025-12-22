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
                      height: he * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: wi * 0.2,
                            height: wi * 0.2,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'),
                                    fit: BoxFit.contain)),
                          ),
                          SizedBox(
                            width: wi * 0.02,
                          ),
                          Text(
                            '4iDeas',
                            style: TextStyle(
                                fontSize: 16.sp, color: ColorManager.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: he * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: wi * 0.07,
                        ),
                        SizedBox(
                          width: wi * 0.02,
                        ),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Based in ',
                                style: GoogleFonts.albertSans(
                                  fontSize: 13.sp,
                                  //fontWeight: FontWeight.bold,
                                  color: ColorManager.orange,
                                ),
                              ),
                              TextSpan(
                                text: 'Richmond, VA ',
                                style: GoogleFonts.albertSans(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.orange),
                              ),
                            ]))
                      ],
                    ),
                    SizedBox(
                      height: he * 0.04,
                    ),
                    Text(
                      'We design and build',
                      style: GoogleFonts.albertSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white,
                      ),
                    ),
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
                    Text(
                      'Just with single Codebase',
                      style: GoogleFonts.albertSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.orange,
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    Container(
                      width: wi * 0.1,
                      height: wi * 0.1,
                      decoration: const BoxDecoration(

                          image: DecorationImage(
                              image: AssetImage('assets/image_7.png'),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    Text(
                      'that give you and your customers the best experience possible',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chilanka(
                        fontSize: 18.sp,
                        //fontWeight: FontWeight.bold,
                        color: ColorManager.white,
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