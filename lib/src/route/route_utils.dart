import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'base_route.dart';
import 'route_config.dart';
import 'route_register_impl.dart';

class RouteUtils {
  RouteUtils._();

  static Future<void> initRoute(RouteConfig config) async {
    final initialLocation = await config.initialLocation;
    config.registerRoute(RouteRegisterImpl());
    RouteRegisterImpl.initRoute(
      initialLocation: initialLocation,
      initialExtra: config.initialExtra,
      observers: config.observers,
      debugLogDiagnostics: config.debugLogDiagnostics,
      navigatorKey: config.navigatorKey,
      redirect: config.routeRedirect,
      refreshListenable: config.refreshListenable,
    );
  }

  static GoRouter get router {
    return RouteRegisterImpl.routeConfig;
  }

  static GlobalKey<NavigatorState> get navigatorKey =>
      RouteRegisterImpl.navigatorKey;

  static BuildContext? get navContext =>
      RouteRegisterImpl.navigatorKey.currentContext;

  static List<GoRoute> get routeStack => RouteRegisterImpl.routeStack;

  static List<String> get pathStack => RouteRegisterImpl.pathStack;

  static String get currentPath => RouteRegisterImpl.currentRoutePath;

  static List<String> get allRouterPath => RouteRegisterImpl.allRouterPath;

  static bool containPathInStack(String? path) {
    return RouteRegisterImpl.containPathInStack(path);
  }

  static bool containName(String? name) {
    return RouteRegisterImpl.containName(name);
  }

  static BaseRoute? getRouteFromName(String? name) {
    return RouteRegisterImpl.getRouteFromName(name);
  }

  static bool containPath(String? path) {
    return RouteRegisterImpl.containPath(path);
  }

  static void go(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.go(location, extra: arguments);

  static Future<Map<String, dynamic>?> push<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.push(location, extra: arguments);

  static Future<Map<String, dynamic>?> pushReplacement<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.pushReplacement(location, extra: arguments);

  static Future<Map<String, dynamic>?> replace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.replace(location, extra: arguments);

  static Future<Map<String, dynamic>?> pushOrReplace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) {
    if (currentPath == location) {
      return router.replace(location, extra: arguments);
    } else {
      return router.push(location, extra: arguments);
    }
  }

  static void popToRoot() => router.go('/');

  static bool canPop() => router.canPop();

  static void pop([Map<String, dynamic>? result]) => router.pop(result);

  static Future<T?> showAppGeneralDialog<T extends Object?>({
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

  static Future<T?> showAppModalBottomSheet<T>({
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
