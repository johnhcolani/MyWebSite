import 'package:flutter/material.dart';
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
    
    // Responsive breakpoints
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Responsive font sizes
    final double titleFontSize = isMobile ? 24 : (isTablet ? 22 : 20);
    final double descriptionFontSize = isMobile ? 16 : (isTablet ? 15 : 14);
    final double appBarTitleSize = isMobile ? 18 : (isTablet ? 20 : 22);
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber[100],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff020923),
        title: Text(
          'Dart Programing Course',
          style: TextStyle(
            color: Colors.white,
            fontSize: appBarTitleSize,
          ),
        ),
      ),
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: wi * 0.05, vertical: he * 0.02),
                    child: Column(
                      children: [
                        Text(
                          'Dart programming \n from scratch for everyone',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: he * 0.02),
                        Text(
                          "it's very easy to learn if you already know Kotlin, it's a 3-4 day job to learn the general structure",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: descriptionFontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: he * 0.03),
                        DartProgramingWidget(
                          he: he,
                          wi: wi,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartWithDartScreen()),
                            );
                          },
                          borderRad: 25,
                          image: Image.asset('assets/image_9.png'),
                          title: 'Start programming with Dart,',
                          subTitle: 'In this section, we will get to know the basics of Dart programming',
                        ),
                        SizedBox(height: he * 0.02),
                        DartProgramingWidget(
                          he: he,
                          wi: wi,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartWithFunctionScreen()),
                            );
                          },
                          borderRad: 25,
                          image: Image.asset('assets/images/function.png'),
                          title: 'Getting started programming with functions,',
                          subTitle: 'On this part, we will learn the functions on darts together',
                        ),
                        SizedBox(height: he * 0.02),
                        DartProgramingWidget(
                          he: he,
                          wi: wi,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartObjectOrientedProgramScreen()),
                            );
                          },
                          borderRad: 25,
                          image: Image.asset('assets/images/object_oriented.png'),
                          title: 'Getting Started Object Oriented Programming,',
                          subTitle: 'In this section, we will learn the concepts of object orientation together',
                        ),
                        SizedBox(height: he * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
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
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Responsive font sizes for widget
    final double widgetTitleSize = isMobile ? 16 : (isTablet ? 15 : 14);
    final double widgetSubtitleSize = isMobile ? 14 : (isTablet ? 13 : 12);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff051136).withValues(alpha: 0.7),
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(borderRad),
        ),
        height: he * 0.16,
        width: wi * 0.9,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: isMobile ? he * 0.06 : he * 0.05,
                height: isMobile ? he * 0.06 : he * 0.05,
                child: image,
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widgetTitleSize,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    Text(
                      subTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widgetSubtitleSize,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: isMobile ? 18 : 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
