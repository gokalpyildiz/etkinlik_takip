part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.isLoading = true});
  final bool isLoading;

  @override
  List<Object> get props => [isLoading];

  HomeState copyWith({bool? isLoading}) {
    return HomeState(isLoading: isLoading ?? this.isLoading);
  }
}
