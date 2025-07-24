import 'package:etkinlik_takip/data/models/base_models/base_pagination_response_model.dart';
import 'package:etkinlik_takip/data/models/event_model.dart';
import 'package:etkinlik_takip/data/services/event_service/IEventService.dart';

final class EventServiceMock implements IEventService {
  @override
  EventServiceMock();
  @override
  Future<BasePaginationModel<EventModel>?> getEvents() async {
    return BasePaginationModel(data: [], success: true);
  }
}
