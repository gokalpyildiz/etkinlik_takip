import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';
import 'package:etkinlik_takip/data/services/network/event_service/IEventService.dart';
import 'package:etkinlik_takip/data/services/network/event_service/event_firebase_service.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';

part 'event_detail_state.dart';

class EventDetailCubit extends BaseCubit<EventDetailState> {
  EventDetailCubit(this.eventId) : super(EventDetailState()) {
    _service = EventFirebaseService.init();
    _init();
  }

  late IEventService _service;
  EventModel? event;
  String eventId;

  Future<void> _init() async {
    final response = await _service.getEvents();
    event = response?.data?.firstWhere((element) => element.id == eventId);
    emit(state.copyWith(isLoading: false));
  }
}
