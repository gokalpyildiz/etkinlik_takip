import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/models/event_model.dart';
import 'package:etkinlik_takip/data/services/event_service/IEventService.dart';
import 'package:etkinlik_takip/data/services/event_service/event_firebase_service.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'home_state.dart';

final class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _service = EventFirebaseService.init();
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
  late IEventService _service;
  late ScrollController scrollController;
  List<EventModel> events = [];
  Future<void> refreshPage() async {
    emit(state.copyWith(isLoading: true));
    var response = await _service.getEvents();
    if (response?.data != null) {
      events = response?.data ?? [];
    }
    emit(state.copyWith(isLoading: false));
  }
}
