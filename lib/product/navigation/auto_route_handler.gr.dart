// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:etkinlik_takip/features/auth/login/view/login_view.dart' as _i5;
import 'package:etkinlik_takip/features/auth/register/view/register_view.dart'
    as _i7;
import 'package:etkinlik_takip/features/auth/splash/view/splash_view.dart'
    as _i8;
import 'package:etkinlik_takip/features/dashboard/dashboard_view.dart' as _i1;
import 'package:etkinlik_takip/features/event_detail/view/event_detail_view.dart'
    as _i2;
import 'package:etkinlik_takip/features/home/view/home_view.dart' as _i4;
import 'package:etkinlik_takip/features/profile/view/profile_view.dart' as _i6;
import 'package:etkinlik_takip/product/navigation/app_router.dart' as _i3;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.DashBoardView]
class DashBoardRoute extends _i9.PageRouteInfo<void> {
  const DashBoardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashBoardView();
    },
  );
}

/// generated route for
/// [_i2.EventDetailView]
class EventDetailRoute extends _i9.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i10.Key? key,
    required String eventId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          EventDetailRoute.name,
          args: EventDetailRouteArgs(
            key: key,
            eventId: eventId,
          ),
          initialChildren: children,
        );

  static const String name = 'EventDetailRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventDetailRouteArgs>();
      return _i2.EventDetailView(
        key: args.key,
        eventId: args.eventId,
      );
    },
  );
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
  });

  final _i10.Key? key;

  final String eventId;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [_i3.HomeTabView]
class HomeTabRoute extends _i9.PageRouteInfo<void> {
  const HomeTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeTabView();
    },
  );
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeView();
    },
  );
}

/// generated route for
/// [_i5.LoginView]
class LoginRoute extends _i9.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i10.Key? key,
    bool showContinueWithoutSigningButton = false,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            showContinueWithoutSigningButton: showContinueWithoutSigningButton,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i5.LoginView(
        key: args.key,
        showContinueWithoutSigningButton: args.showContinueWithoutSigningButton,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.showContinueWithoutSigningButton = false,
  });

  final _i10.Key? key;

  final bool showContinueWithoutSigningButton;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, showContinueWithoutSigningButton: $showContinueWithoutSigningButton}';
  }
}

/// generated route for
/// [_i3.ProfileTabView]
class ProfileTabRoute extends _i9.PageRouteInfo<void> {
  const ProfileTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTabRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProfileTabView();
    },
  );
}

/// generated route for
/// [_i6.ProfileView]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProfileView();
    },
  );
}

/// generated route for
/// [_i7.RegisterView]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.RegisterView();
    },
  );
}

/// generated route for
/// [_i8.SplashView]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashView();
    },
  );
}
