enum MediaType {
  image,
  video,
}

class MediaItem {
  final MediaType type;
  final String mediaId;
  final String url;

  const MediaItem({
    required this.type,
    required this.mediaId,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "mediaId": mediaId,
      "url": url,
    };
  }

  MediaItem.fromJson(Map<String, dynamic> json)
      : type = json["type"] == null
            ? MediaType.image
            : json["type"] == MediaType.image.name
                ? MediaType.image
                : MediaType.video,
        mediaId = json["mediaId"] ?? "",
        url = json["url"] ?? "";
}
