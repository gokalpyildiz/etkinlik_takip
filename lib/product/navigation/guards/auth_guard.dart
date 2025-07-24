import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/product/functions/token_operation.dart';
import 'package:etkinlik_takip/product/navigation/app_router.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';

class AuthNavigationObserver extends AutoRouteGuard {
  final Set<String> _allowedPages = {AppRoute.splash, AppRoute.login, AppRoute.register, '/'};

  @override
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var isExpired = await TokenOperation.instance.tokenIsExpire();
    if (_allowedPages.contains(resolver.route.name) && !isExpired) {
      resolver.next(true);
    } else {
      router.replaceAll([LoginRoute()]);
    }
  }
}
