import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/ColorManager.dart';

class MenuItem extends StatefulWidget {
  final String title;
  final  icon;

  const MenuItem({super.key, required this.icon, required this.title});

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
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: wi < 500 ? 12.sp : 8.sp, color: ColorManager.white),
          textAlign: TextAlign.end,
        ),
        leading: Icon(widget.icon,
            size: wi < 500 ? 18.sp : 10.sp, color: ColorManager.white),
      ),
    );
  }
}
