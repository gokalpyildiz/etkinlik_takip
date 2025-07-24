part of 'event_detail_cubit.dart';

class EventDetailState extends Equatable {
  const EventDetailState({this.isLoading = true, this.showSuccesConnection = false});
  final bool isLoading;
  final bool showSuccesConnection;

  @override
  List<Object> get props => [isLoading, showSuccesConnection];

  EventDetailState copyWith({bool? isLoading, bool? showSuccesConnection}) {
    return EventDetailState(isLoading: isLoading ?? this.isLoading, showSuccesConnection: showSuccesConnection ?? this.showSuccesConnection);
  }
}
