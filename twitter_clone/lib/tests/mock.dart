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

final testPosts = [
  testPostType1,
  testPostType2,
  testPostType3,
  testPostType4,
  testPostType5,
  testPostType6,
  testPostType7,
];

final testPostType1 = Post(
  postId: uuid.v4(),
  authorId: "test-id-1",
  authorName: "pobity",
  content: "Vine after seeing the Threads logo unveiled.",
  timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
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
);

final testPostType2 = Post(
  postId: uuid.v4(),
  authorId: "test-id-2",
  authorName: "thetinderblog",
  content: "Elon alone on Twitter right now...",
  timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  comments: List.generate(
    12,
    (index) => Comment(
      authorId: uuid.v4(),
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 120,
  shares: 14,
  authorImgPath: testUserImgPath,
  media: [
    ImageItem(
      mediaId: uuid.v4(),
      url: testPostImgPath,
    ),
  ],
);

final testPostType3 = Post(
  postId: uuid.v4(),
  authorId: "test-id-3",
  authorName: "tropicalseductions",
  content: "Drop a comment here to test things out.",
  timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
  comments: List.generate(
    2,
    (index) => Comment(
      authorId: uuid.v4(),
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 4,
  shares: 0,
  isCertificatedUser: true,
  authorImgPath: testUserImgPath,
);

final testPostType4 = Post(
  postId: uuid.v4(),
  authorId: "test-id-4",
  authorName: "shityoushouldcareabout",
  content: "my phone feels like a vibrator with all these notifications rn",
  timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 39)),
  comments: List.generate(
    64,
    (index) => Comment(
      authorId: uuid.v4(),
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 631,
  shares: 72,
  isCertificatedUser: true,
  authorImgPath: testUserImgPath,
);

final testPostType5 = Post(
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
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 14,
  shares: 18,
  isCertificatedUser: true,
  authorImgPath: testUserImgPath,
);

final testPostType6 = Post(
  postId: uuid.v4(),
  authorId: "test-id-6",
  authorName: "terracottacoco",
  content: "",
  timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 54)),
  comments: List.generate(
    12,
    (index) => Comment(
      authorId: uuid.v4(),
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 34,
  shares: 20,
  isCertificatedUser: true,
  media: [
    ImageItem(
      mediaId: uuid.v4(),
      url: testPostImgPath,
    ),
  ],
  authorImgPath: testUserImgPath,
);

final testPostType7 = Post(
  postId: uuid.v4(),
  authorId: "test-id-7",
  authorName: "timferriss",
  content: "Photoshoot with Molly pup. :)",
  timestamp: DateTime.now().subtract(const Duration(hours: 7, minutes: 12)),
  comments: List.generate(
    53,
    (index) => Comment(
      authorId: uuid.v4(),
      authorImgPath: testUserImgPath,
      content: "$index Hello World.",
    ),
  ).toList(),
  likes: 437,
  shares: 30,
  isCertificatedUser: true,
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
  authorImgPath: testUserImgPath,
);
