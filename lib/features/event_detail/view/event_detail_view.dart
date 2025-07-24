import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/features/event_detail/cubit/event_detail_cubit.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/my_scaffold.dart';
import 'package:etkinlik_takip/product/widgets/common/padding/project_padding.dart';
import 'package:etkinlik_takip/product/widgets/common/photo_widget.dart';
import 'package:etkinlik_takip/product/widgets/common/text/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit(eventId),

      child: MyScaffold(
        appBar: AppBar(title: const Text('Etkinlik Detayları')),
        child: BlocBuilder<EventDetailCubit, EventDetailState>(
          builder: (context, state) {
            final cubit = context.read<EventDetailCubit>();
            if (state.isLoading) return Center(child: const CircularProgressIndicator());
            if (cubit.event == null) return Center(child: const Text('Etkinlik Bulunamadı'));
            final event = cubit.event;
            return Padding(
              padding: const ProjectPadding.pageContentPadding(),
              child: Column(
                children: [
                  Card(
                    color: context.colorScheme.onSecondary,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          MyText(event!.title ?? ''),
                          EventPhotoWidget(imageList: event.imageList),
                          MyText(event.description ?? ''),
                          MyText(event.date.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
