import 'dart:typed_data';

class User {
  final String userId;
  String? userName;
  Uint8List? userImage;

  User({
    required this.userId,
    this.userName = "",
    this.userImage,
  });
}
