// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/cache/hive/constants/hive_type_ids.dart';
import 'package:etkinlik_takip/data/models/event_model.dart';
import 'package:hive/hive.dart';
part 'event_list_model.g.dart';

@HiveType(typeId: HiveTypeIds.eventListModel)
class EventListModel extends Equatable {
  const EventListModel({this.events});
  @HiveField(0)
  final List<EventModel>? events;

  @override
  List<Object?> get props => [events];
}
