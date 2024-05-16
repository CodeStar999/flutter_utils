import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import 'base_route.dart';
import 'route_register.dart';

@internal
class RouteRegisterImpl extends RouteRegister {
  static final RouteRegisterImpl _instance = RouteRegisterImpl._();

  factory RouteRegisterImpl() => _instance;

  RouteRegisterImpl._();

  late GoRouter _goRouter;

  static GoRouter get routeConfig => _instance._goRouter;

  static GlobalKey<NavigatorState> get navigatorKey =>
      routeConfig.configuration.navigatorKey;

  final Map<String, BaseRoute> _pathRoutes = {};

  final Map<String, BaseRoute> _nameRoutes = {};

  static List<GoRoute> get routeStack =>
      routeConfig.routerDelegate.currentConfiguration.routes
          .map((e) => e as GoRoute)
          .toList();

  static GoRouterDelegate get delegate => routeConfig.routerDelegate;

  static List<String> get pathStack => routeStack.map((e) => e.path).toList();

  static String get currentRoutePath {
    final RouteMatch lastMatch = delegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : delegate.currentConfiguration;
    return matchList.uri.toString();
  }

  static List<String> get allRouterPath =>
      _instance._pathRoutes.values.map((e) => e.path).toList();

  @override
  void register(BaseRoute route) {
    assert(!_nameRoutes.containsKey(route.name), "name has been registered");
    assert(!_pathRoutes.containsKey(route.path), "name has been registered");
    _pathRoutes[route.path] = route;
    _nameRoutes[route.name] = route;
  }

  static bool containPathInStack(String? path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    return pathStack.contains(path);
  }

  static bool containName(String? name) {
    if (name == null || name.isEmpty) {
      return false;
    }
    return _instance._nameRoutes.containsKey(name);
  }

  static BaseRoute? getRouteFromName(String? name) {
    if (!containName(name)) {
      return null;
    }
    return _instance._nameRoutes[name];
  }

  static bool containPath(String? path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    return _instance._pathRoutes.containsKey(path);
  }

  static BaseRoute? getRouteFromPath(String? path) {
    if (!containPath(path)) {
      return null;
    }
    return _instance._pathRoutes[path];
  }

  static List<GoRoute> get getAllRoutes {
    return _instance._pathRoutes.values.map((e) => e.createRoute()).toList();
  }

  void _createRoute({
    String? initialLocation,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    BaseRoute? rootRoute,
  }) {
    List<GoRoute> routes = getAllRoutes;
    if (rootRoute != null) {
      final root = rootRoute.createRoute(routes: routes);
      routes = [root];
    }
    _goRouter = GoRouter(
      routes: routes,
      initialLocation: initialLocation,
      initialExtra: initialExtra,
      observers: observers,
      debugLogDiagnostics: debugLogDiagnostics,
      navigatorKey: navigatorKey,
      redirect: redirect,
      refreshListenable: refreshListenable,
    );
  }

  @internal
  static void initRoute({
    String? initialLocation,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    BaseRoute? rootRoute,
  }) {
    _instance._createRoute(
      initialLocation: initialLocation,
      initialExtra: initialExtra,
      observers: observers,
      debugLogDiagnostics: debugLogDiagnostics,
      navigatorKey: navigatorKey,
      redirect: redirect,
      refreshListenable: refreshListenable,
      rootRoute: rootRoute,
    );
  }
}
