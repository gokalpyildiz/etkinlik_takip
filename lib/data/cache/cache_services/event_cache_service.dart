import 'package:etkinlik_takip/data/cache/core/manager/cache_operation.dart';
import 'package:etkinlik_takip/data/cache/hive/constants/database_keys.dart';
import 'package:etkinlik_takip/data/models/event_models/event_list_model.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';

class EventCacheService {
  EventCacheService({required CacheOperation<EventListModel> eventListCacheOperation}) {
    _eventListCacheOperation = eventListCacheOperation;
  }
  late CacheOperation<EventListModel> _eventListCacheOperation;

  Future<EventListModel?> getEvents() async {
    var cacheEvents = await _eventListCacheOperation.get(DatabaseKeys.EVENTS_MAIN.value);
    return cacheEvents;
  }

  Future<void> setEvents(List<EventModel> events) async {
    await _eventListCacheOperation.add(
      key: DatabaseKeys.EVENTS_MAIN.value,
      item: EventListModel(events: events),
    );
  }
}
