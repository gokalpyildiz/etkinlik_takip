import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> refreshPage() async {}
}
