import 'package:etkinlik_takip/data/cache/core/manager/cache_manager.dart';
import 'package:etkinlik_takip/data/cache/core/manager/cache_operation.dart';
import 'package:etkinlik_takip/data/cache/hive/constants/hive_box_names.dart';
import 'package:etkinlik_takip/data/cache/hive/hive_cache_operation.dart';
import 'package:etkinlik_takip/data/models/event_models/event_list_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager}) : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async => await _cacheManager.init();

  late final CacheOperation<TokenModel> tokenCacheOperation = HiveCacheOperation<TokenModel>(HiveBoxNames.token.value);
  late final CacheOperation<EventListModel> eventListCacheOperation = HiveCacheOperation<EventListModel>(HiveBoxNames.eventList.value);
}
