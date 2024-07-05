import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/models/post.dart';

class PostRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    try {
      Post newPost = post.copyWith();
      newPost = newPost.copyWith(media: await uploadMedias(newPost));
      await _db.collection("posts").doc(post.postId).set(newPost.toJson());
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<List<MediaItem>> uploadMedias(Post post) async {
    try {
      if (post.media != null) {
        List<MediaItem> updatedMediaList = List<MediaItem>.from(post.media!);
        for (int i = 0; i < updatedMediaList.length; i++) {
          MediaItem media = updatedMediaList[i];
          if (media.fileUrl != null) {
            final fileRef = _storage
                .ref()
                .child("/posts/${post.postId}/medias/${media.mediaId}");

            var file = File(media.fileUrl!);

            if (media.type == MediaType.image) {
              file = await getCompressedImage(file, media.mediaId);
            }

            final result = await fileRef.putFile(file);

            if (result.metadata != null) {
              final mediaUrl = await result.ref.getDownloadURL();
              updatedMediaList[i] = media.copyWith(url: mediaUrl);
            }
          }
        }
        return updatedMediaList;
      }
      return [];
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return [];
    }
  }

  Future<File> getCompressedImage(File image, String mediaId) async {
    try {
      var compressedImage = await FlutterImageCompress.compressWithList(
        await image.readAsBytes(),
        quality: 30,
      );

      final directory = await getApplicationDocumentsDirectory();
      final tempDirectory = Directory('${directory.path}/temp');

      if (!await tempDirectory.exists()) {
        await tempDirectory.create(recursive: true);
      }

      final path = '${tempDirectory.path}/$mediaId.png';

      return await File(path).writeAsBytes(compressedImage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return File(image.path);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> fetchPosts({
    DateTime? lastItemTimestamp,
  }) async {
    try {
      final query = _db
          .collection("posts")
          .orderBy("timestamp", descending: true)
          .limit(3);

      if (lastItemTimestamp == null) {
        return await query.get();
      } else {
        return await query
            .startAfter([lastItemTimestamp.toIso8601String()]).get();
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return null;
    }
  }
}

final postRepo = Provider((ref) => PostRepository());
