// ignore_for_file: await_only_futures

import 'dart:async';

import 'package:etkinlik_takip/data/cache/hive/constants/database_keys.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:etkinlik_takip/product/navigation/app_router.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';

class AuthOperation {
  AuthOperation._init();
  static final AuthOperation _instance = AuthOperation._init();
  static AuthOperation get instance => _instance;
  final _tokenCache = ProductStateItems.productCache.tokenCacheOperation;

  Timer? _tokenControlTimer;

  Future<void> setToken(TokenModel token) async {
    await _tokenCache.add(key: DatabaseKeys.TOKEN.value, item: token);
    startControlToken();
  }

  void clear() {
    _tokenControlTimer?.cancel();
    _tokenCache.clear();
  }

  Future<TokenModel?> get getTokenModel async => (await _tokenCache.get(DatabaseKeys.TOKEN.value));

  Future<String?> getToken() async {
    var tokenModel = await _tokenCache.get(DatabaseKeys.TOKEN.value);
    final isExpire = tokenModel?.expiration?.isBefore(DateTime.now());
    if (isExpire ?? true) {
      return null;
    }
    return tokenModel?.token;
  }

  Future<bool> tokenIsExpire() async {
    var tokenModel = await _tokenCache.get(DatabaseKeys.TOKEN.value);
    final isExpire = tokenModel?.expiration?.isBefore(DateTime.now());
    return isExpire ?? true;
  }

  Future<Duration?> _getRemainingTokenTime() async {
    final tokenModel = await getTokenModel;
    final remainingTime = tokenModel?.expiration?.difference(DateTime.now());
    return remainingTime;
  }

  Future<void> startControlToken() async {
    _tokenControlTimer?.cancel();
    final remainingTime = await _getRemainingTokenTime();
    if ((remainingTime?.inMinutes ?? 0) <= 2 || remainingTime == null) {
      _tokenControlTimer?.cancel();
      routeLogin();
      return;
    }
    _tokenControlTimer = Timer.periodic(remainingTime, (timer) async {
      final remainingTime = await _getRemainingTokenTime();
      if ((remainingTime?.inMinutes ?? 0) <= 3) {
        _tokenControlTimer?.cancel();
        routeLogin();
      }
    });
  }

  void routeLogin() {
    var currentUrl = ProductStateItems.appRouterHandler.currentUrl;
    final isAllowForGuest = currentUrl == AppRoute.splash || currentUrl == AppRoute.login || currentUrl == AppRoute.register || currentUrl == '/';
    if (!isAllowForGuest) {
      ProductStateItems.appRouterHandler.replaceAll([LoginRoute()]);
    }
  }
}
