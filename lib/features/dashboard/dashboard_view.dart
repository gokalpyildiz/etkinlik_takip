import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/features/dashboard/viewmodel/dashboard_cubit.dart';
import 'package:etkinlik_takip/product/assets/asset.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});
  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    var activeColor = context.colorScheme.secondary;
    return BlocProvider.value(
      value: ProductStateItems.dashboardCubit,
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) => AutoTabsScaffold(
          routes: [const HomeRoute(), const ProfileRoute()],
          lazyLoad: true,
          transitionBuilder: (context, child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          bottomNavigationBuilder: (context, tabsRouter) {
            return AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              crossFadeState: state.isInnerScrool ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              secondChild: const SizedBox(),
              firstChild: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: context.colorScheme.surfaceContainer)),
                ),
                child: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (value) async {
                    context.tabsRouter.setActiveIndex(value);
                  },
                  selectedItemColor: activeColor,
                  selectedFontSize: 13,
                  unselectedFontSize: 11,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Assets.svg.home.svg(),
                      label: 'Anasayfa',
                      activeIcon: Assets.svg.home.svg(colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn)),
                    ),
                    BottomNavigationBarItem(
                      icon: Assets.svg.user.svg(),
                      label: 'Profil',
                      activeIcon: Assets.svg.user.svg(colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
