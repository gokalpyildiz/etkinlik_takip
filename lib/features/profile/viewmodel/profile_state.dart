part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.isLoading = true});
  final bool isLoading;

  @override
  List<Object> get props => [isLoading];

  ProfileState copyWith({bool? isLoading}) {
    return ProfileState(isLoading: isLoading ?? this.isLoading);
  }
}
