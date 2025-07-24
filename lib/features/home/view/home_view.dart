import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/data/models/event_model.dart';
import 'package:etkinlik_takip/features/home/view/widgets/subwidgets/shimmer/home_shimmer.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/extensions/widget_extension.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/my_scaffold.dart';
import 'package:etkinlik_takip/product/widgets/common/snackbars/ftoast_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mixin.dart/home_view_mixin.dart';
part 'widgets/subwidgets/photo_widget.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with SingleTickerProviderStateMixin, HomeViewMixin {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: RefreshIndicator(
      edgeOffset: 100,
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
              appBar: AppBar(title: const Text('Etkinlikler')),
              child: CustomScrollView(
                controller: cubit.scrollController,
                slivers: [
                  ElevatedButton(child: Text('Yenile'), onPressed: () => cubit.refreshPage()).toSliver,
                  const SizedBox(height: 28).toSliver,
                  SliverList(
                    delegate: SliverChildListDelegate([
                      cubit.events.isEmpty
                          ? const Center(child: Text('Etkinlik bulunamadı.'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.events.length,
                              itemBuilder: (context, index) {
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
                                );
                              },
                            ),
                    ]),
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
