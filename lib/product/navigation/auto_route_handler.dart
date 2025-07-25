import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/product/navigation/app_router.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...AppRoute.routes];
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
}
