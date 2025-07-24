// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({this.isInnerScrool = false, this.isRefreshingTabbar = false});
  final bool isInnerScrool;
  final bool isRefreshingTabbar;

  @override
  List<Object> get props => [isInnerScrool, isRefreshingTabbar];

  DashboardState copyWith({
    bool? isInnerScrool,
    bool? isRefreshingTabbar,
  }) {
    return DashboardState(
      isInnerScrool: isInnerScrool ?? this.isInnerScrool,
      isRefreshingTabbar: isRefreshingTabbar ?? this.isRefreshingTabbar,
    );
  }
}
