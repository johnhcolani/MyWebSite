
import 'package:flutter/material.dart';
import 'package:my_web_site/helper/app_background.dart';
import 'package:sizer/sizer.dart';

class StartWithDartScreen extends StatefulWidget {
  const StartWithDartScreen({super.key});

  @override
  State<StartWithDartScreen> createState() => _StartWithDartScreenState();
}

class _StartWithDartScreenState extends State<StartWithDartScreen> {
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
        title: const Text('Start With Dart',style: TextStyle(color: Colors.white),),
      ),
      body: const Stack(
        children: [
          AppBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('Page under construction',style: TextStyle(fontSize: 32,color: Colors.white),)),
            ],
          )
          // CustomScrollView(
          //   slivers: [
          //     SliverToBoxAdapter(
          //       child:
          //     ),
          //     SliverToBoxAdapter(
          //
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}


