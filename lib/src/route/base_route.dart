import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

@internal
abstract class BaseRoute extends GoRouteData {
  String get path;

  String get name => runtimeType.toString();

  List<GoRoute> get subRoutes => [];

  Map<String, dynamic> get pageInfo => {};

  @internal
  GoRoute createRoute({List<GoRoute> routes = const []}) {
    return GoRoute(
      path: path,
      name: name,
      builder: build,
      pageBuilder: buildPage,
      redirect: redirect,
      routes: routes.isNotEmpty ? routes : subRoutes,
    );
  }
}
