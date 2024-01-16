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
                      height: wi * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: wi * 0.08 ,
                                  height: wi * 0.08,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/logo.png'),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                              SizedBox(
                                height: wi * 0.1,
                              ),
                              Text(
                                '4iDeas',
                                style: TextStyle(
                                    fontSize: wi> 500 ? 11.sp : 16.sp, color: ColorManager.white),
                              ),
                              SizedBox(
                                height: wi * 0.1,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: wi * 0.1,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: wi * 0.03,
                              ),
                              SizedBox(
                                width: wi * 0.02,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Based in ',
                                      style: GoogleFonts.albertSans(
                                        fontSize: 8.sp,
                                        //fontWeight: FontWeight.bold,
                                        color: ColorManager.orange,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Richmond, VA ',
                                      style: GoogleFonts.albertSans(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.orange),
                                    ),
                                  ]))
                            ],
                          ),
                        ],
                      ),
                    ),



                    SizedBox(
                      height: he * 0.08,
                    ),
                    Text(
                      'We design and build',
                      style: GoogleFonts.albertSans(
                        fontSize: 18.sp,
                        //fontWeight: FontWeight.bold,
                        color: ColorManager.white,
                      ),
                    ),
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
                      style: GoogleFonts.albertSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white,
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
