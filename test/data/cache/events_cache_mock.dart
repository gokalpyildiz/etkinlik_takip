import 'package:etkinlik_takip/data/cache/core/manager/cache_operation.dart';
import 'package:etkinlik_takip/data/models/event_models/event_list_model.dart';

class EventsCacheMock extends CacheOperation<EventListModel> {
  final List<EventListModel> _events = [];
  @override
  Future<void> add({required String key, required EventListModel item}) async {
    _events.add(item);
  }

  @override
  Future<EventListModel?> get(String key) async {
    return _events.firstOrNull;
  }

  @override
  Future<void> clear() async {}

  @override
  Future<List<EventListModel>?> getAll() async {
    return _events;
  }

  @override
  Future<void> insert({required EventListModel item}) async {}

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> removeAt(int index) async {}

  @override
  Future<void> update({required EventListModel item, required int index}) async {}
}
