import 'package:etkinlik_takip/features/home/view/widgets/subwidgets/shimmer/home_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Etkinlikler')),
    body: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [shimmerList()]),
      ),
    ),
  );

  Widget shimmerList() => Column(children: buildShimmerList());

  List<Widget> buildShimmerList() => List.generate(
    10,
    (index) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TitlePlaceholder(width: double.infinity, height: 32),
    ),
  );
}
