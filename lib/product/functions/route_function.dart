import 'package:etkinlik_takip/product/navigation/app_router.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';

class RouteFunction {
  RouteFunction._init();
  static final RouteFunction _instance = RouteFunction._init();
  static RouteFunction get instance => _instance;

  bool navigateToDetail(String detailId) {
    var currentUrl = ProductStateItems.appRouterHandler.currentUrl;
    final blocNavigate = currentUrl == AppRoute.splash || currentUrl == AppRoute.login || currentUrl == AppRoute.register || currentUrl == '/';
    if (!blocNavigate) {
      ProductStateItems.appRouterHandler.push(EventDetailRoute(eventId: detailId));
      return true;
    } else {
      return false;
    }
  }
}
