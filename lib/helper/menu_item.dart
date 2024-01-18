import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/ColorManager.dart';

class MenuItem extends StatefulWidget {
  final String title;
  final  IconData icon;
  final VoidCallback onPressed;


  const MenuItem({super.key, required this.icon, required this.title, required this.onPressed});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Container(
      child: ListTile(
        title: TextButton(
          onPressed: (){
            widget.onPressed.call();
          },
          child: Text(widget.title,
          style: TextStyle(
              fontSize: wi < 500 ? 12.sp : 8.sp, color: ColorManager.white),
          textAlign: TextAlign.center,
        )),
        leading: Icon(widget.icon,
            size: wi < 500 ? 18.sp : 10.sp, color: ColorManager.white),
      ),
    );
  }
}
