import 'package:twitter_clone/models/base/media_item.dart';

class VideoItem extends MediaItem {
  VideoItem({
    required super.mediaId,
    required super.url,
    super.filePath = "",
  });
}
