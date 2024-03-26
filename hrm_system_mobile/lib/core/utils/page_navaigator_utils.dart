import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// It pushes a widget with a fade transition.
///
/// Args:
///   [context] (BuildContext): The context of the current widget.
///   [widget] (Widget): The widget you want to push to the navigation stack.
pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 50),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return widget;
        }),
  );
}

/// It pushes a widget with a fade transition and a callback function.
///
/// Args:
///   [context] (BuildContext): The context of the current widget.
///   [widget] (Widget): The widget you want to push to the navigation stack.
///   [callBack] (Function): This is the function that will be called when the widget is popped.
pushWidgetWithFadeCallback(BuildContext context, Widget widget, Function callBack) {
  Navigator.of(context)
      .push(
    PageRouteBuilder(transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    }, pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return widget;
    }),
  )
      .then((value) {
    if (kDebugMode) {
      print("Navigation Back click");
    }
    callBack();
    if (kDebugMode) {
      print("Run callback function");
    }
  });
}

/// It pushes a widget with a slide animation.
///
/// Args:
///   [context] (BuildContext): The context of the current widget.
///   [widget] (Widget): The widget you want to push to the navigation stack.
pushWidgetWithSlide(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    PageRouteBuilder(transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }, pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return widget;
    }),
  );
}
