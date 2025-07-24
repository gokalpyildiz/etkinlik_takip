// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventListModelAdapter extends TypeAdapter<EventListModel> {
  @override
  final int typeId = 3;

  @override
  EventListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventListModel(
      events: (fields[0] as List?)?.cast<EventModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.events);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
