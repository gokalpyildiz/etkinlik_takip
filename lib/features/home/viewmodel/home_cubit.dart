import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'home_state.dart';

final class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    scrollController = ScrollController();
    // Sayfanın altlarına gidildikçe tabbarın animasyonlu şekilde gizler
    scrollController.addListener(() {
      if (scrollController.positions.length > 1) {
        scrollController.detach(scrollController.positions.first);
      }
      var isInnerScroll = scrollController.position.userScrollDirection == ScrollDirection.reverse;
      ProductStateItems.dashboardCubit.setInnerScroll(isInnerScroll);
    });
  }
  late ScrollController scrollController;
  Future<void> refreshPage() async {}
}
