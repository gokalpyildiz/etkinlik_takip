import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/cache/hive/constants/hive_type_ids.dart';
import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: HiveTypeIds.eventModel)
class EventModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime? date;
  @HiveField(4)
  final List<String>? imageList;

  const EventModel({this.title, this.description, this.date, this.imageList, this.id});
  @override
  List<Object?> get props => [title, description, date, imageList];
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(title: map['title'], description: map['description'], date: DateTime.parse(map['date']), imageList: map['imageList']);
  }
  factory EventModel.fromFirestore(dynamic doc) {
    final data = doc.data();
    return EventModel(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      id: doc.id,
      imageList: (data['imageList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'date': date?.toIso8601String(), 'imageList': imageList};
  }

  EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: (json['date'] as DateTime),
      imageList: (json['imageList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  EventModel copyWith({String? title, String? description, DateTime? date, List<String>? imageList}) {
    return EventModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      imageList: imageList ?? this.imageList,
    );
  }
}
