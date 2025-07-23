import 'package:etkinlik_takip/features/home/view/home_view.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  late HomeCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = ProductStateItems.homeCubit; //HomeCubit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
