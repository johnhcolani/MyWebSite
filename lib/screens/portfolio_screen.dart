
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_web_site/helper/app_background.dart';
import 'package:sizer/sizer.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
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
        title: const Text('Portfolio',style: TextStyle(color: Colors.white),),
      ),
      body:  Stack(
        alignment: AlignmentDirectional.center,
        children: [
          AppBackground(),
          Container(
            height: 100,
            width: 100,
            color: Colors.yellowAccent,
          ),
          Positioned(
            left: 25,
            top: 25,
            child: Container(
              height: 50,
              width: 50,
              color: Colors.red,
            ),
          ),
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


