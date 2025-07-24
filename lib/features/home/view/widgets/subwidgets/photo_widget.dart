part of '../../home_view.dart';

class EventPhotoWidget extends StatelessWidget {
  const EventPhotoWidget({super.key, this.imageList});
  final List<String?>? imageList;

  @override
  Widget build(BuildContext context) {
    const photoHeight = 150.0;
    if (imageList?.isEmpty ?? true) return const SizedBox.shrink();
    return SizedBox(
      height: photoHeight,
      child: ListView.builder(
        itemCount: imageList?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final image = imageList?[index];
          if (image == null) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.network(
              image,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: context.colorScheme.error, height: photoHeight, width: photoHeight, child: const Icon(Icons.no_photography));
              },
            ),
          );
        },
      ),
    );
  }
}
