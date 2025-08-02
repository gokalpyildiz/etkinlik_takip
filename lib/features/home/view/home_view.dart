import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';
import 'package:etkinlik_takip/features/home/view/widgets/subwidgets/shimmer/home_shimmer.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/extensions/widget_extension.dart';
import 'package:etkinlik_takip/product/firebase/firebase_core/firebase_messaging.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/my_scaffold.dart';
import 'package:etkinlik_takip/product/widgets/common/custom_sliver_header.dart';
import 'package:etkinlik_takip/product/widgets/common/photo_widget.dart';
import 'package:etkinlik_takip/product/widgets/common/smart_refresh_indicator.dart';
import 'package:etkinlik_takip/product/widgets/common/snackbars/ftoast_snackbar.dart';
import 'package:etkinlik_takip/product/widgets/common/text/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mixin.dart/home_view_mixin.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with SingleTickerProviderStateMixin, HomeViewMixin {
  @override
  void initState() {
    super.initState();
    FbMessaging.instance.processPendingNotification();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: SmartRefreshIndicator(
      onRefresh: () async {
        await cubit.refreshPage();
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        buildWhen: (previous, current) => previous.isLoading != current.isLoading,
        listenWhen: (previous, current) => previous.showSuccesConnection != current.showSuccesConnection,
        listener: (context, state) {
          if (state.showSuccesConnection) {
            FlutterToast.showSuccessful(context, title: 'Yeniden Bağlandı');
          }
        },
        builder: (context, state) {
          if (state.isLoading) return HomeShimmer();
          return PopScope(
            canPop: false,
            child: MyScaffold(
              child: CustomScrollView(
                controller: cubit.scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: CustomSliverHeader(
                      minHeight: 60,
                      maxHeight: 120,
                      child: Container(
                        color: context.colorScheme.secondaryContainer,
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                          child: Align(alignment: AlignmentDirectional.center, child: const MyText.displayLarge('Etkinlikler', isAnimated: true)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28).toSliver,
                  SliverList(
                    delegate: cubit.events.isEmpty
                        ? SliverChildListDelegate([const Center(child: Text('Etkinlik bulunamadı.'))])
                        : SliverChildBuilderDelegate((context, index) {
                            final EventModel event = cubit.events[index];
                            return Card(
                              color: context.colorScheme.primaryContainer,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(event.title ?? 'No Title'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(event.description ?? ''),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: EventPhotoWidget(imageList: event.imageList),
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                                trailing: Text(
                                  '${event.date?.day}.${event.date?.month}.${event.date?.year}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ).toGesture(
                              onTap: () {
                                if (event.id != null) {
                                  context.router.push(EventDetailRoute(eventId: event.id!));
                                }
                              },
                            );
                          }, childCount: cubit.events.length),
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
