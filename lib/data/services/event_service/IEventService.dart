import 'package:etkinlik_takip/data/models/base_models/base_pagination_response_model.dart';
import 'package:etkinlik_takip/data/models/event_model.dart';

abstract class IEventService {
  Future<BasePaginationModel<EventModel>?> getEvents();
}
