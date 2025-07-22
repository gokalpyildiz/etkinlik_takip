// ignore_for_file: await_only_futures

import 'dart:async';

import 'package:etkinlik_takip/data/cache/hive/constants/database_keys.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';

class TokenOperation {
  TokenOperation._init();
  static final TokenOperation _instance = TokenOperation._init();
  static TokenOperation get instance => _instance;
  final _tokenCache = ProductStateItems.productCache.tokenCacheOperation;

  Future<void> setToken(TokenModel token) async {
    await _tokenCache.add(key: DatabaseKeys.TOKEN.value, item: token);
  }

  void clear() {
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
}
