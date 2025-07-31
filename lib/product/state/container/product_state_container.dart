import 'package:etkinlik_takip/data/cache/cache_services/event_cache_service.dart';
import 'package:etkinlik_takip/data/cache/hive/hive_cache_manager.dart';
import 'package:etkinlik_takip/data/cache/product_cache.dart';
import 'package:etkinlik_takip/data/services/core_services/connectivity_service/connectivity_service.dart';
import 'package:etkinlik_takip/data/services/network/event_service/event_firebase_service.dart';
import 'package:etkinlik_takip/features/dashboard/viewmodel/dashboard_cubit.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:etkinlik_takip/features/profile/viewmodel/profile_cubit.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';
import 'package:get_it/get_it.dart';

/// Uygulama bağımlılıklarını merkezileştirdiğimiz Dependency Injection işlemlerini ProductContainer ile yönetiriz
final class ProductContainer {
  const ProductContainer._();
  static final _getIt = GetIt.I;

  static void setup() {
    //sürekli açık olması ve her yerden erişilmesi gereken bloc sınıfları burada tanımlanmalı
    _getIt
      ..registerSingleton<ProductCache>(ProductCache(cacheManager: HiveCacheManager()))
      ..registerLazySingleton<AppRouter>(AppRouter.new)
      ..registerLazySingleton<DashboardCubit>(DashboardCubit.new)
      ..registerLazySingleton<ProductCubit>(ProductCubit.new)
      ..registerLazySingleton<ProfileCubit>(ProfileCubit.new)
      ..registerLazySingleton(() {
        return HomeCubit(
          eventCacheFunc: EventCacheService(eventListCacheOperation: ProductStateItems.productCache.eventListCacheOperation),
          eventService: EventFirebaseService.init(),
          connectivityService: ConnectivityService(),
        );
      });
  }

  /// read your dependency item for [ProductContainer]
  static T readDepInj<T extends Object>() => _getIt<T>();
}
