import 'dart:math';

import 'package:twitter_clone/models/comment.dart';
import 'package:twitter_clone/models/image_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/util/generate_util.dart';

final testUserInfo = User(
  userId: uuid.v4(),
  userName: "umm_jun_sick",
  email: "dongtan.sugundoduk@umjun.sick",
  phoneNum: "1577-1577",
  birthDate: DateTime(1991, 9, 4),
  userImgPath: "https://avatars.githubusercontent.com/u/34933982?v=4",
);

const testConfirmationPin = "000000";

class PostMock {
  static const testUserImgList = [
    "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/3792581/pexels-photo-3792581.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/610294/pexels-photo-610294.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/4098157/pexels-photo-4098157.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/3778876/pexels-photo-3778876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/3094215/pexels-photo-3094215.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ];

  static const testPostImgList = [
    "https://images.pexels.com/photos/346529/pexels-photo-346529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/18978089/pexels-photo-18978089.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/20721303/pexels-photo-20721303.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/17886629/pexels-photo-17886629.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/13861099/pexels-photo-13861099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/23294334/pexels-photo-23294334.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/20717262/pexels-photo-20717262.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/25184787/pexels-photo-25184787.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/25016476/pexels-photo-25016476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ];

  static final testPosts = [
    testPostType1,
    testPostType2,
    testPostType3,
    testPostType4,
    testPostType5,
    testPostType6,
    testPostType7,
  ];

  static final testPostType1 = Post(
    postId: uuid.v4(),
    authorId: "test-id-1",
    authorName: "pobity",
    content: "Vine after seeing the Threads logo unveiled.",
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    comments: List.generate(
      36,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 391,
    shares: 24,
    isCertificatedUser: true,
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
    media: [
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
    ],
  );

  static final testPostType2 = Post(
    postId: uuid.v4(),
    authorId: "test-id-2",
    authorName: "thetinderblog",
    content: "Elon alone on Twitter right now...",
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    comments: List.generate(
      12,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 120,
    shares: 14,
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
    media: [
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
    ],
  );

  static final testPostType3 = Post(
    postId: uuid.v4(),
    authorId: "test-id-3",
    authorName: "tropicalseductions",
    content: "Drop a comment here to test things out.",
    timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
    comments: List.generate(
      2,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 4,
    shares: 0,
    isCertificatedUser: true,
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
  );

  static final testPostType4 = Post(
    postId: uuid.v4(),
    authorId: "test-id-4",
    authorName: "shityoushouldcareabout",
    content: "my phone feels like a vibrator with all these notifications rn",
    timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 39)),
    comments: List.generate(
      64,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 631,
    shares: 72,
    isCertificatedUser: true,
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
  );

  static final testPostType5 = Post(
    postId: uuid.v4(),
    authorId: "test-id-5",
    authorName: "_plantswithkrystal_",
    content:
        "If you're reading this, go water that thirsty plant. You're welcome ☺️",
    timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 48)),
    comments: List.generate(
      1,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 14,
    shares: 18,
    isCertificatedUser: true,
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
  );

  static final testPostType6 = Post(
    postId: uuid.v4(),
    authorId: "test-id-6",
    authorName: "terracottacoco",
    content: "",
    timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 54)),
    comments: List.generate(
      12,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 34,
    shares: 20,
    isCertificatedUser: true,
    media: [
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
    ],
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
  );

  static final testPostType7 = Post(
    postId: uuid.v4(),
    authorId: "test-id-7",
    authorName: "timferriss",
    content: "Photoshoot with Molly pup. :)",
    timestamp: DateTime.now().subtract(const Duration(hours: 7, minutes: 12)),
    comments: List.generate(
      53,
      (index) => Comment(
        authorId: uuid.v4(),
        authorImgPath:
            testUserImgList[Random().nextInt(testUserImgList.length)],
        content: "$index Hello World.",
      ),
    ).toList(),
    likes: 437,
    shares: 30,
    isCertificatedUser: true,
    media: [
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
      ImageItem(
        mediaId: uuid.v4(),
        url: testPostImgList[Random().nextInt(testPostImgList.length)],
      ),
    ],
    authorImgPath: testUserImgList[Random().nextInt(testUserImgList.length)],
  );
}
