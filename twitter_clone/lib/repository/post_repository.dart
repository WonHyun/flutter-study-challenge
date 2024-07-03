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
    Post newPost = post.copyWith();
    if (newPost.media != null) {
      List<MediaItem> updatedMediaList = List<MediaItem>.from(newPost.media!);
      for (int i = 0; i < updatedMediaList.length; i++) {
        MediaItem media = updatedMediaList[i];
        if (media.fileUrl != null) {
          final fileRef = _storage
              .ref()
              .child("/posts/${post.postId}/medias/${media.mediaId}");
          final result = await fileRef.putFile(File(media.fileUrl!));
          if (result.metadata != null) {
            final mediaUrl = await result.ref.getDownloadURL();
            updatedMediaList[i] = media.copyWith(url: mediaUrl);
          }
        }
      }
      newPost = newPost.copyWith(media: updatedMediaList);
    }
    await _db.collection("posts").doc(post.postId).set(newPost.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts({
    DateTime? lastItemTimestamp,
  }) async {
    final query =
        _db.collection("posts").orderBy("timestamp", descending: true).limit(3);

    if (lastItemTimestamp == null) {
      return await query.get();
    } else {
      return await query
          .startAfter([lastItemTimestamp.toIso8601String()]).get();
    }
  }
}

final postRepo = Provider((ref) => PostRepository());
