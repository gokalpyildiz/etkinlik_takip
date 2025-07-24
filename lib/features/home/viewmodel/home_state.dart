part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.isLoading = true, this.showSuccesConnection = false});
  final bool isLoading;
  final bool showSuccesConnection;

  @override
  List<Object> get props => [isLoading, showSuccesConnection];

  HomeState copyWith({bool? isLoading, bool? showSuccesConnection}) {
    return HomeState(isLoading: isLoading ?? this.isLoading, showSuccesConnection: showSuccesConnection ?? this.showSuccesConnection);
  }
}
