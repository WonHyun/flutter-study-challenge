import 'package:twitter_clone/global/enum.dart';

ProfileTab convToInitTabFromUrlQuery(String? initTab) {
  return initTab != null && initTab == "replies"
      ? ProfileTab.replies
      : ProfileTab.threads;
}
