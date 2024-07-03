enum MediaType {
  image,
  video,
}

class MediaItem {
  final MediaType type;
  final String mediaId;
  final String url;
  final String? fileUrl;

  const MediaItem({
    required this.type,
    required this.mediaId,
    required this.url,
    this.fileUrl,
  });

  MediaItem copyWith({
    MediaType? type,
    String? mediaId,
    String? url,
    String? fileUrl,
  }) {
    return MediaItem(
      type: type ?? this.type,
      mediaId: mediaId ?? this.mediaId,
      url: url ?? this.url,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }

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
        url = json["url"] ?? "",
        fileUrl = null;
}
