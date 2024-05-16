import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import 'base_route.dart';
import 'route_register_impl.dart';

@internal
mixin RouteMixin {
  GoRouter get router {
    return RouteRegisterImpl.routeConfig;
  }

  GlobalKey<NavigatorState> get navigatorKey => RouteRegisterImpl.navigatorKey;

  BuildContext? get navContext => RouteRegisterImpl.navigatorKey.currentContext;

  List<GoRoute> get routeStack => RouteRegisterImpl.routeStack;

  List<String> get pathStack => RouteRegisterImpl.pathStack;

  String get currentPath => RouteRegisterImpl.currentRoutePath;

  List<String> get allRouterPath => RouteRegisterImpl.allRouterPath;

  bool containPathInStack(String? path) {
    return RouteRegisterImpl.containPathInStack(path);
  }

  bool containName(String? name) {
    return RouteRegisterImpl.containName(name);
  }

  BaseRoute? getRouteFromName(String? name) {
    return RouteRegisterImpl.getRouteFromName(name);
  }

  bool containPath(String? path) {
    return RouteRegisterImpl.containPath(path);
  }

  BaseRoute? getRouteFromPath(String? path) {
    return RouteRegisterImpl.getRouteFromPath(path);
  }

  void addListener(VoidCallback listener) {
    RouteRegisterImpl.delegate.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    RouteRegisterImpl.delegate.removeListener(listener);
  }

  void go(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.go(location, extra: arguments);

  Future<Map<String, dynamic>?> push<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.push(location, extra: arguments);

  Future<Map<String, dynamic>?> pushReplacement<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.pushReplacement(location, extra: arguments);

  Future<Map<String, dynamic>?> replace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.replace(location, extra: arguments);

  Future<Map<String, dynamic>?> pushOrReplace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) {
    if (currentPath == location) {
      return router.replace(location, extra: arguments);
    } else {
      return router.push(location, extra: arguments);
    }
  }

  void popToRoot() => router.go('/');

  bool canPop() => router.canPop();

  void pop([Map<String, dynamic>? result]) => router.pop(result);

  Future<T?> showAppGeneralDialog<T extends Object?>({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      return Future.value(null);
    }
    return showGeneralDialog(
      context: context,
      pageBuilder: pageBuilder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  Future<T?> showAppModalBottomSheet<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      return Future.value(null);
    }
    return showModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
    );
  }
}
