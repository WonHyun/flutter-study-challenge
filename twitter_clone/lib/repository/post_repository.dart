import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/models/post.dart';

class PostRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toJson());
  }

  UploadTask uploadMediaFile(File media, String mediaId, String postId) {
    final fileRef = _storage.ref().child("/$postId/$mediaId");
    return fileRef.putFile(media);
  }

  Future<void> saveMedia(MediaItem media, String postId) async {
    if (media.type == MediaType.image) {
      await _db.collection("posts").doc(postId).update(
        {"media": media.toJson()},
      );
    } else {}
  }
}

final postRepo = Provider((ref) => PostRepository());
