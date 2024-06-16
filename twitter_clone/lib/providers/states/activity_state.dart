import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/activity.dart';

class ActivityState {
  final List<Activity> activitys;
  final List<Activity> filteredActivitys;
  final ActivityType currentType;

  const ActivityState({
    this.activitys = const [],
    this.filteredActivitys = const [],
    this.currentType = ActivityType.all,
  });

  ActivityState copyWith({
    List<Activity>? activitys,
    List<Activity>? filteredActivitys,
    ActivityType? currentType,
  }) {
    return ActivityState(
      activitys: activitys ?? this.activitys,
      currentType: currentType ?? this.currentType,
      filteredActivitys: filteredActivitys ?? this.filteredActivitys,
    );
  }
}
