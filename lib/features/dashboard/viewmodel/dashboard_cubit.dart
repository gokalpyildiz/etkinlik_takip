import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';

part 'dashboard_state.dart';

class DashboardCubit extends BaseCubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  //sayfa scroll olduğunda tabbarı gizler
  void setInnerScroll(bool isInnerScroll) {
    if (state.isInnerScrool == isInnerScroll) return;
    emit(state.copyWith(isInnerScrool: isInnerScroll));
  }

  void setRefreshingTabbar() {
    emit(state.copyWith(isRefreshingTabbar: true));
    emit(state.copyWith(isRefreshingTabbar: false));
  }
}
