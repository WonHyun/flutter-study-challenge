import 'package:faker/faker.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final faker = Faker();

class UserGenerator {
  static String generateTestUserId({
    String? baseId,
  }) {
    final spaceSeperator = faker.randomGenerator.boolean() ? "_" : ".";
    return baseId == null
        ? faker.person.name().toLowerCase().replaceAll(" ", spaceSeperator)
        : baseId.toLowerCase().replaceAll(" ", spaceSeperator);
  }

  static List<User> getRandomUsers({int userCount = 10}) {
    final name = faker.person.name();
    final company = faker.company.name();
    final selector = faker.randomGenerator.integer(3);
    late final String randomId;
    switch (selector) {
      case 0:
        randomId = name;
      case 1:
        randomId = company;
      case 2:
        randomId = name + company;
      default:
        randomId = name;
    }

    return List.generate(
      userCount,
      (index) {
        return User(
          userId: UserGenerator.generateTestUserId(baseId: randomId),
          userName: name,
          email: faker.internet.email(),
          phoneNum: faker.phoneNumber.us(),
          birthDate: faker.date.dateTime(),
          agreementStatus: {},
          interests: {},
          userImgPath: 'https://picsum.photos/200?random=$index',
          isCertificatedUser: faker.randomGenerator.boolean(),
          followUsers: [],
        );
      },
    );
  }
}
