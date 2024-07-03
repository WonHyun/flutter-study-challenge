class Comment {
  final String authorId;
  final String authorImgPath;
  final String content;

  const Comment({
    required this.authorId,
    required this.authorImgPath,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "authorId": authorId,
      "authorImgPath": authorImgPath,
      "content": content,
    };
  }

  Comment.fromJson(Map<String, dynamic> json)
      : authorId = json["authorId"],
        authorImgPath = json["authorImgPath"],
        content = json["content"];
}
