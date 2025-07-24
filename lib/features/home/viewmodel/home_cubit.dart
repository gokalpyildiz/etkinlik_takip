import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/cache/cache_services/event_cache_service.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';
import 'package:etkinlik_takip/data/services/connectivity_service/IConnectivityService.dart';
import 'package:etkinlik_takip/data/services/event_service/IEventService.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'home_state.dart';

final class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({required EventCacheService eventCacheFunc, required IEventService eventService, required IConnectivityService connectivityService})
    : super(HomeState()) {
    _service = eventService;
    scrollController = ScrollController();
    _connectivityFunction = connectivityService;
    _eventCacheFunc = eventCacheFunc;
    _setScrollListener();
  }
  late EventCacheService _eventCacheFunc;
  late IConnectivityService _connectivityFunction;
  late IEventService _service;
  late ScrollController scrollController;
  List<EventModel> events = [];
  bool hasConnection = true;
  Future<void> refreshPage() async {
    emit(state.copyWith(isLoading: true));
    hasConnection = await _connectivityFunction.isConnected;
    if (hasConnection) {
      await _setEvents();
    } else {
      await _getEventsWithCache();
      _connectivityFunction.connectivityStream.listen((results) async {
        final response = results.any((result) => result != ConnectivityResult.none);
        //bağlantı vardı ve kesildi ise var olan datayı göstermeye devam etmeli. sayfanın yenilenmesine gerek yok
        if (!response) {
          hasConnection = response;
          //bağlantı yoktu ve bağlantı geldi ise sayfayı yenilemeli
        } else if (!hasConnection && response) {
          emit(state.copyWith(isLoading: true, showSuccesConnection: true));
          await _getEventsWithCache();
          emit(state.copyWith(isLoading: false, showSuccesConnection: false));
        }
      });
      await _getEventsWithCache();
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _getEventsWithCache() async {
    final response = await _eventCacheFunc.getEvents();
    events = (response?.events?.toList()) ?? [];
  }

  Future<void> _setEventsWithCache(List<EventModel> events) async {
    await _eventCacheFunc.setEvents(events);
  }

  Future<void> _setEvents() async {
    var response = await _service.getEvents();
    if (response?.data != null) {
      _setEventsWithCache(response?.data ?? []);
      events = response?.data ?? [];
    }
  }

  void _setScrollListener() {
    // Sayfanın altlarına gidildikçe tabbarın animasyonlu şekilde gizler
    scrollController.addListener(() {
      if (scrollController.positions.length > 1) {
        scrollController.detach(scrollController.positions.first);
      }
      var isInnerScroll = scrollController.position.userScrollDirection == ScrollDirection.reverse;
      ProductStateItems.dashboardCubit.setInnerScroll(isInnerScroll);
    });
  }
}
