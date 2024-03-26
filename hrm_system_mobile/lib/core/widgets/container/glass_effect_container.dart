import 'dart:ui';
import 'package:flutter/material.dart';

class GlassEffectContainerWidget extends StatelessWidget {
  final double borderRadius, blur, borderwidth;
  final Widget child;
  final double? width;
  final double? height;
  final Color bgcolor;

  const GlassEffectContainerWidget({Key? key, this.blur = 5.0, required this.child, this.borderRadius = 8.0, this.bgcolor = Colors.white, this.borderwidth = 1.5, this.width, this.height})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: bgcolor.withOpacity(0.2), borderRadius: BorderRadius.circular(borderRadius), border: Border.all(width: borderwidth, color: bgcolor.withOpacity(0.1))),
          child: child,
        ),
      ),
    );
  }
}
