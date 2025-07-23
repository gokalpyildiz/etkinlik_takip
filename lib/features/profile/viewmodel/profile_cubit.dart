import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  Future<void> refreshBottomVies() async {}
}
