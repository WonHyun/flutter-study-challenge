import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/activity.dart';
import 'package:twitter_clone/providers/states/activity_state.dart';

class ActivityNotifier extends StateNotifier<ActivityState> {
  ActivityNotifier(super.state);

  void updateCurrentType(ActivityType type) {
    state = state.copyWith(currentType: type);
  }

  void updateActivitys(List<Activity> activitys) {
    state = state.copyWith(activitys: activitys);
  }

  void updateFilteredActivitys(List<Activity> filteredActivitys) {
    state = state.copyWith(filteredActivitys: filteredActivitys);
  }

  void changeFilter(ActivityType type) {
    if (type == ActivityType.all) {
      updateFilteredActivitys(state.activitys);
    } else {
      updateFilteredActivitys(
          state.activitys.where((value) => value.type == type).toList());
    }
    updateCurrentType(type);
  }

  void removeActivity(Activity activity) {
    final newActivitys = state.activitys
        .where(
          (value) => value.activityId != activity.activityId,
        )
        .toList();
    updateActivitys(newActivitys);
    changeFilter(state.currentType);
  }
}
