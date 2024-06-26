abstract class MediaItem {
  final String mediaId;
  final String url;
  // TODO: Will be delete, it is test property
  final String filePath;

  const MediaItem({
    required this.mediaId,
    required this.url,
    required this.filePath,
  });
}
