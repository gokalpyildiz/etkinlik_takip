part of '../../home_view.dart';

class EventPhotoWidget extends StatelessWidget {
  const EventPhotoWidget({super.key, this.imageList});
  final List<String?>? imageList;

  @override
  Widget build(BuildContext context) {
    if (imageList?.isEmpty ?? true) return const SizedBox.shrink();
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: imageList?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final image = imageList?[index];
          if (image == null) return const SizedBox.shrink();
          return Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Image.network(image));
        },
      ),
    );
  }
}
