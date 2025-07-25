import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/navigation/guards/duplicate_guard.dart';

class AppRoute {
  //static const initial = Routes.splash;
  /// Auth Routes
  static const splash = '/*';
  static const login = '/login';
  static const register = '/register';

  /// Dashboard Routes
  static const dashboard = '/dashboard';
  static const home = 'home';
  static const homeTab = 'homeTab';
  static const profile = 'profile';
  static const profileTab = 'profileTab';

  //subroutes
  static const eventDetail = 'eventDetail';

  static DuplicateGuard duplicateGuard = DuplicateGuard();
  static final _commonGuards = [duplicateGuard];
  static AutoRoute splashRoute = CustomRoute<void>(
    initial: true,
    path: splash,
    page: SplashRoute.page,
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 500,
    guards: [..._commonGuards],
  );
  static AutoRoute loginRoute = AutoRoute(path: login, page: LoginRoute.page, guards: [..._commonGuards]);
  static AutoRoute registerRoute = AutoRoute(path: register, page: RegisterRoute.page, guards: [..._commonGuards]);
  static AutoRoute dashboardRoute = AutoRoute(
    path: dashboard,
    page: DashBoardRoute.page,
    children: [
      AutoRoute(
        page: HomeTabRoute.page,
        path: homeTab,
        maintainState: true,
        children: [
          AutoRoute(path: home, page: HomeRoute.page, initial: true, guards: [..._commonGuards]),
          AutoRoute(path: eventDetail, page: EventDetailRoute.page),
        ],
      ),
      AutoRoute(
        path: profile,
        page: ProfileTabRoute.page,
        children: [AutoRoute(path: profile, page: ProfileRoute.page)],
      ),
    ],
  );

  static List<AutoRoute> routes = [splashRoute, dashboardRoute, loginRoute, registerRoute];
}

@RoutePage()
class HomeTabView extends AutoRouter {
  const HomeTabView({super.key});
}

@RoutePage()
class ProfileTabView extends AutoRouter {
  const ProfileTabView({super.key});
}
