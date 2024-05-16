import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../provider/controller/base_controller.dart';
import '../provider/widget/provider_state_builder.dart';
import 'base_route.dart';

typedef WidgetRouteBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

typedef PageRouteBuilder = Page<void> Function(
  BuildContext context,
  Widget child,
);

class CommonRoute extends BaseRoute {
  final String routePath;
  final WidgetRouteBuilder builder;
  final PageRouteBuilder? pageBuilder;

  CommonRoute({
    required this.routePath,
    this.pageBuilder,
    required this.builder,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (pageBuilder != null) {
      return pageBuilder!.call(context, builder(context, state));
    }
    return super.buildPage(context, state);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if (pageBuilder == null) {
      return builder(context, state);
    }
    return super.build(context, state);
  }

  @override
  String get path => routePath;

  @override
  String get name => 'CommonRoute_${routePath.replaceAll("/", '')}';
}

class CommonStateRoute<T extends BaseController> extends BaseRoute {
  final String routePath;
  final T Function(
    BuildContext context,
    GoRouterState state,
  ) create;
  final WidgetBuilder builder;
  final PageRouteBuilder? pageBuilder;

  CommonStateRoute({
    required this.routePath,
    required this.create,
    this.pageBuilder,
    required this.builder,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (pageBuilder != null) {
      final child = ProviderStateBuilder<T>(
        create: (cxt) {
          final controller = createController(
            context,
            state,
          );
          return controller;
        },
        child: Builder(
          builder: (BuildContext context) {
            return builder(context);
          },
        ),
      );
      return pageBuilder!.call(context, child);
    }
    return super.buildPage(context, state);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if (pageBuilder == null) {
      return ProviderStateBuilder<T>(
        create: (cxt) {
          final controller = createController(
            context,
            state,
          );
          return controller;
        },
        child: Builder(
          builder: (BuildContext context) {
            return builder(context);
          },
        ),
      );
    }
    return super.build(context, state);
  }

  @protected
  T createController(BuildContext context, GoRouterState state) {
    return create(context, state);
  }

  @override
  String get path => routePath;

  @override
  String get name => 'StateRoute_${routePath.replaceAll("/", '')}';
}
