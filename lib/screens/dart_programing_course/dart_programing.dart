import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_web_site/helper/app_background.dart';
import 'package:my_web_site/screens/dart_programing_course/start_object_oriented_program.dart';
import 'package:my_web_site/screens/dart_programing_course/start_with_dart.dart';
import 'package:my_web_site/screens/dart_programing_course/start_with_function.dart';
import 'package:sizer/sizer.dart';

class DartPrograming extends StatefulWidget {
  const DartPrograming({super.key});

  @override
  State<DartPrograming> createState() => _DartProgramingState();
}

class _DartProgramingState extends State<DartPrograming> {
  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(
          color: Colors.amber[100],
        ),
centerTitle: true,
        backgroundColor: const Color(0xff020923),
        title: const Text('Dart Programing Course',style: TextStyle(color: Colors.white)),
      ),
      body: Stack(

        children: [
          const AppBackground(),

          Column(
              children: [
                Text('Dart programming \n from scratch for everyone',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13.sp),textAlign: TextAlign.center,),
                SizedBox(
                  height: he* 0.02,
                ),
                const Text("it's very easy to learn if you already know Kotlin, it's a 3-4 day job to learn the general structure",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),


              ],
            ),

        Align(
          alignment: Alignment(0,0.2),
          child: Expanded(
            child: Container(
              height: he*0.7,
              //color: Colors.red,
              child: CustomScrollView(
                  slivers: [
            
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: he,
                        width: 200,
                        child: SafeArea(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              DartProgramingWidget(
                                he: he,
                                wi: wi,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StartWithDartScreen()));
                                },
                                borderRad: 25,
                                image: Image.asset('assets/image_9.png'),
                                title: 'Start programming with Dart,',
                                subTitle:
                                    'In this section, we will get to know the basics of Dart programming',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              DartProgramingWidget(
                                he: he,
                                wi: wi,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StartWithFunctionScreen()));
                                },
                                borderRad: 25,
                                image: Image.asset('assets/images/function.png'),
                                title: 'Getting started programming with functions,',
                                subTitle:
                                'On this part, we will learn the functions on darts together',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              DartProgramingWidget(
                                he: he,
                                wi: wi,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StartObjectOrientedProgramScreen()));
                                },
                                borderRad: 25,
                                image: Image.asset('assets/images/object_oriented.png'),
                                title: 'Getting Started Object Oriented Programming,',
                                subTitle:
                                'In this section, we will learn the concepts of object orientation together',
                              ),
            
            
            
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ),
          ),
        ),

        ],
      ),
    );
  }
}

class DartProgramingWidget extends StatelessWidget {
  const DartProgramingWidget(
      {super.key,
      required this.he,
      required this.wi,
      required this.onTap,
      required this.borderRad,
      required this.image,
      required this.title,
      required this.subTitle});

  final double he;
  final double wi;
  final VoidCallback onTap;
  final double borderRad;
  final Image image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff051136).withOpacity(0.7),
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(borderRad)),
        height: he * 0.16,
        width: wi * 0.9,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    )),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 10.sp),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: he * 0.05, width: he * 0.05, child: image)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
