import 'package:etkinlik_takip/data/cache/hive/hive_cache_manager.dart';
import 'package:etkinlik_takip/data/cache/product_cache.dart';
import 'package:etkinlik_takip/features/dashboard/viewmodel/dashboard_cubit.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:etkinlik_takip/features/profile/viewmodel/profile_cubit.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';
import 'package:get_it/get_it.dart';

/// Product container for dependency injection
final class ProductContainer {
  const ProductContainer._();
  static final _getIt = GetIt.I;

  /// Product core required items
  static void setup() {
    //buraya eklenenler ProductStateItems a eklenerek kullanılabilir.
    _getIt
      //lazysingleton çağrıldığında oluşturulur verimlilik için, singleton doğrudan kullanılır.
      ..registerSingleton<ProductCache>(ProductCache(cacheManager: HiveCacheManager()))
      ..registerLazySingleton<AppRouter>(AppRouter.new)
      ..registerLazySingleton<DashboardCubit>(DashboardCubit.new)
      ..registerLazySingleton<ProductCubit>(ProductCubit.new)
      ..registerLazySingleton<ProfileCubit>(ProfileCubit.new)
      ..registerLazySingleton(() {
        return HomeCubit();
      });
  }

  /// read your dependency item for [ProductContainer]
  static T readDepInj<T extends Object>() => _getIt<T>();
}
