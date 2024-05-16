import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

enum PageSlideDirection {
  leftToRight(Offset(-1.0, 0.0)),
  rightToLeft(Offset(1.0, 0.0)),
  downToUp(Offset(0.0, 1.0)),
  upToDown(Offset(0.0, -1.0));

  final Offset offset;

  const PageSlideDirection(this.offset);

  AnimatedWidget _slide({
    required Widget child,
    required Animation<double> animation,
    Curve curve = Curves.easeInOut,
  }) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
        ),
        child: child);
  }

  CustomTransitionPage<T> transitionPage<T>({
    required Widget child,
    Curve curve = Curves.easeInOut,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool opaque = true,
    bool barrierDismissible = false,
    Color? barrierColor,
    String? barrierLabel,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      child: child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      opaque: opaque,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return _slide(
          child: child,
          animation: animation,
          curve: curve,
        );
      },
    );
  }
}
