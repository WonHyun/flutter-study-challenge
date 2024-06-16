import 'package:faker/faker.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/activity.dart';
import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/comment.dart';
import 'package:twitter_clone/models/image_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final faker = Faker();

class UserGenerator {
  static String generateUserId({
    String? baseId,
  }) {
    late final String spaceSeperator;
    switch (faker.randomGenerator.integer(3)) {
      case 0:
        spaceSeperator = "_";
      case 1:
        spaceSeperator = ".";
      case 2:
        spaceSeperator = "";
      default:
        spaceSeperator = "";
    }

    return baseId == null
        ? faker.person.name().toLowerCase().replaceAll(" ", spaceSeperator)
        : baseId
            .replaceAll(RegExp(r'[.,_-]'), "")
            .replaceAll("'", "")
            .toLowerCase()
            .replaceAll(" ", spaceSeperator);
  }

  static List<User> getRandomUsers({int userCount = 10}) {
    return List.generate(
      userCount,
      (index) {
        final name = faker.person.name();
        final company = faker.company.name();
        final animal = faker.animal.name();
        final color = faker.color.color();
        final selector = faker.randomGenerator.integer(5);
        final followerTotalCounts = faker.randomGenerator.boolean()
            ? faker.randomGenerator.integer(1000000)
            : faker.randomGenerator.integer(20000);
        final followingTotalCounts = faker.randomGenerator.integer(1000);

        late final String randomId;
        switch (selector) {
          case 0:
            randomId = name;
          case 1:
            randomId = company;
          case 2:
            randomId = name + company;
          case 3:
            randomId = animal;
          case 4:
            randomId = color + animal;
          default:
            randomId = color + name;
        }

        return User(
          userId: UserGenerator.generateUserId(baseId: randomId),
          userName: name,
          email: faker.internet.email(),
          phoneNum: faker.phoneNumber.us(),
          birthDate: faker.date.dateTime(minYear: 1950, maxYear: 2010),
          agreementStatus: {},
          interests: {},
          userImgPath:
              "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
          isCertificatedUser: faker.randomGenerator.boolean(),
          followers: [],
          followerTotalCounts: followerTotalCounts,
          follwingTotalCounts: followingTotalCounts,
        );
      },
    );
  }
}

class PostGenerator {
  static List<Post> getRandomPosts({int postCount = 10, List<User>? users}) {
    return List.generate(
      postCount,
      (index) {
        final now = DateTime.now();
        late final User user;
        if (users != null && users.isEmpty) {
          user = users[faker.randomGenerator.integer(users.length)];
        } else {
          user = UserGenerator.getRandomUsers(userCount: 1).first;
        }

        String postId = uuid.v4();
        String authorId = user.userId;
        String authorName = user.userName ?? user.userId;
        String authorImgPath = user.userImgPath ??
            "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}";
        bool isCertificatedUser = user.isCertificatedUser ?? false;

        String content = faker.lorem
            .sentences(faker.randomGenerator.integer(5, min: 1))
            .join(" ");

        List<MediaItem> media = List.generate(
          faker.randomGenerator.integer(3),
          (index) {
            return ImageItem(
              mediaId: uuid.v4(),
              url:
                  "https://picsum.photos/500?random=${faker.randomGenerator.integer(500)}",
            );
          },
        );

        DateTime timestamp = faker.date.dateTime(minYear: 2023, maxYear: 2024);
        if (timestamp.isAfter(now)) {
          timestamp = now;
          timestamp.subtract(
            Duration(
              minutes: faker.randomGenerator.integer(50),
            ),
          );
        }
        bool isAllowedComment =
            faker.randomGenerator.boolean() || faker.randomGenerator.boolean();
        bool isLiked = false;
        List<Comment> comments = [];
        int commentCounts = 0;
        if (isAllowedComment) {
          final counts = faker.randomGenerator.boolean()
              ? faker.randomGenerator.integer(300)
              : faker.randomGenerator.integer(10);
          commentCounts = counts;
          comments = List.generate(
            commentCounts > 5 ? 5 : commentCounts,
            (index) {
              late final User commentUser;
              if (users != null && users.isEmpty) {
                commentUser =
                    users[faker.randomGenerator.integer(users.length)];
              } else {
                commentUser = UserGenerator.getRandomUsers(userCount: 1).first;
              }
              return Comment(
                authorId: commentUser.userId,
                authorImgPath: commentUser.userImgPath ??
                    "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
                content: faker.lorem
                    .sentences(faker.randomGenerator.integer(3, min: 1))
                    .join(" "),
              );
            },
          );
        }
        int likes = faker.randomGenerator.boolean()
            ? faker.randomGenerator.integer(1000)
            : faker.randomGenerator.integer(100);
        int shares = faker.randomGenerator.boolean()
            ? faker.randomGenerator.integer(500)
            : faker.randomGenerator.integer(50);

        return Post(
          postId: postId,
          authorId: authorId,
          authorName: authorName,
          authorImgPath: authorImgPath,
          isCertificatedUser: isCertificatedUser,
          content: content,
          media: media,
          timestamp: timestamp,
          isLiked: isLiked,
          comments: comments,
          likes: likes,
          shares: shares,
          isAllowedComment: isAllowedComment,
          commentTotalCounts: commentCounts,
        );
      },
    );
  }
}

class ActivityGenerator {
  static List<Activity> getRandomActivitys({int activityCount = 10}) {
    return List.generate(
      activityCount,
      (index) {
        final now = DateTime.now();
        final testActivityTypeList = ActivityType.values.where((value) {
          switch (value) {
            case ActivityType.mentions:
            case ActivityType.follow:
            case ActivityType.like:
            case ActivityType.repost:
              return true;
            default:
              return false;
          }
        }).toList();
        final type = testActivityTypeList[
            faker.randomGenerator.integer(testActivityTypeList.length)];
        final timestamp = faker.date.dateTimeBetween(
          now.subtract(
            Duration(
              hours: faker.randomGenerator.integer(5),
              minutes: faker.randomGenerator.integer(59),
            ),
          ),
          now,
        );
        final user = UserGenerator.getRandomUsers(userCount: 1).first;
        var content = faker.lorem
            .sentences(faker.randomGenerator.integer(2, min: 1))
            .join(" ");
        if (type == ActivityType.mentions) {
          content = "$content@${user.userId}";
        }
        final originalPostContent = faker.lorem
            .sentences(faker.randomGenerator.integer(2, min: 1))
            .join(" ");
        return Activity(
          type: type,
          timestamp: timestamp,
          user: user,
          content: content,
          originalPostContent: originalPostContent,
        );
      },
    );
  }
}
