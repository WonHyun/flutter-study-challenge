import 'package:flutter/material.dart';
import 'package:twitter_clone/models/media_item.dart';

class PostMediaListView extends StatelessWidget {
  const PostMediaListView({
    super.key,
    required this.medias,
    this.mediaWidth = 300,
    this.height = 200,
  });

  final List<MediaItem> medias;
  final double mediaWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: height,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: medias.length,
            itemBuilder: (context, index) {
              if (medias[index].type == MediaType.image) {
                return Container(
                  width: mediaWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    medias[index].url,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (medias[index].type == MediaType.video) {
                return Container(
                  width: mediaWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    medias[index].url,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
