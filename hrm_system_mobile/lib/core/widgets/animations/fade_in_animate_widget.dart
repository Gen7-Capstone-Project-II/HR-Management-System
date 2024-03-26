import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:simple_animations/simple_animations.dart';

///
/// [FadeAnimateWidget]
///
class FadeAnimateWidget extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimateWidget(
    this.delay,
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = TimelineTween()
      ..addScene(begin: Duration.zero, end: const Duration(milliseconds: 500))
          .animate(
            E_ANIMATE_TYPE.OPACITY,
            tween: Tween(begin: 0.0, end: 1.0),
          )
          .animate(
            E_ANIMATE_TYPE.TRANSLATE_Y,
            tween: Tween(begin: -30.0, end: 0.0),
            curve: Curves.easeOut,
          );

    return PlayAnimation<TimelineValue>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(E_ANIMATE_TYPE.OPACITY),
        child: Transform.translate(
          offset: Offset(
            0,
            animation.get(E_ANIMATE_TYPE.TRANSLATE_Y),
          ),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
