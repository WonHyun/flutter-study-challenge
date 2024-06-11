import 'package:twitter_clone/models/comment.dart';
import 'package:twitter_clone/models/image_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/util/generate_util.dart';

final testUserInfo = User(
  userId: uuid.v4(),
  userName: "Umm Jun Sik",
  email: "dongtan.sugundoduk@umjun.sick",
  phoneNum: "1577-1577",
  birthDate: DateTime(1991, 9, 4),
);

const testConfirmationPin = "000000";

const testUserImgPath =
    "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

const testPostImgPath =
    "https://images.pexels.com/photos/346529/pexels-photo-346529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

final testPosts = List.generate(
  10,
  (index) => Post(
    postId: uuid.v4(),
    authorId: "test-id-1",
    authorName: "pobity",
    content:
        "Vine after seeing the Threads logo unveiled. Vine after seeing the Threads logo unveiled.",
    timestamp: DateTime.now().subtract(const Duration(hours: 10, minutes: 2)),
    comments: List.generate(
      36,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath: testUserImgPath,
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 391,
    shares: 24,
    isCertificatedUser: true,
    authorImgPath: testUserImgPath,
    media: [
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgPath,
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgPath,
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgPath,
      ),
    ],
  ),
).toList();
