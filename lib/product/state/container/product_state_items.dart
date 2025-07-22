import 'package:etkinlik_takip/data/cache/product_cache.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.dart';
import 'package:etkinlik_takip/product/state/container/product_state_container.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';

final class ProductStateItems {
  const ProductStateItems._();

  static ProductCubit get productCubit => ProductContainer.readDepInj<ProductCubit>();

  static ProductCache get productCache => ProductContainer.readDepInj<ProductCache>();
  static AppRouter get appRouterHandler => ProductContainer.readDepInj<AppRouter>();
}
