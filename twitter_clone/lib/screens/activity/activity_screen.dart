import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/activity/components/activity_list_item.dart';
import 'package:twitter_clone/screens/activity/components/activity_type_list_item.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  static const routeName = "activity";
  static const routePath = "/activity";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityProvider);
    final activityNotifier = ref.watch(activityProvider.notifier);
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            toolbarHeight: 100,
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Activity",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 35,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ActivityType.values
                        .map(
                          (value) => Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ActivityTypeListItem(
                              type: value,
                              isSelected: value == activityState.currentType,
                              onTap: () => activityNotifier.changeFilter(value),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: activityState.filteredActivitys.length,
                  itemBuilder: (context, index) {
                    final activity = activityState.filteredActivitys[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        bottom: 10,
                      ),
                      child: ActivityListItem(
                        activity: activity,
                        onDismissed: activityNotifier.removeActivity,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
