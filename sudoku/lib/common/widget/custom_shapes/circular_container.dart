import 'package:flutter/material.dart';
class TCircularContainer extends StatelessWidget {
  const TCircularContainer({super.key,

    this.width=400,
    this.height=400,
    this.radius=400,
    this.padding=0,
    this.child,
    this.backgroundColor=Colors.white,
    this.margin,
  });

  final double? height;
  final double? width;
  final double radius;
  final double padding;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}