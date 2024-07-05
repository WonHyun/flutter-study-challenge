import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/models/user_profile.dart';

class SearchRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UserProfile>> searchUsers(String keyword) async {
    var query = _db
        .collection("users")
        .where("displayUserId", isGreaterThanOrEqualTo: keyword)
        .where("displayUserId", isLessThanOrEqualTo: "$keyword\uf8ff")
        .limit(10)
        .get();

    final result = await query;

    final users =
        result.docs.map((doc) => UserProfile.fromJson(doc.data())).toList();

    return users;
  }

  Future<List<Post>> searchPosts(String keyword) async {
    var query = _db
        .collection("posts")
        .where("content", isGreaterThanOrEqualTo: keyword)
        .where("content", isLessThanOrEqualTo: "$keyword\uf8ff")
        .limit(5)
        .get();

    final result = await query;

    final posts = result.docs.map((doc) => Post.fromJson(doc.data())).toList();

    return posts;
  }
}

final searchRepo = Provider((ref) => SearchRepository());
