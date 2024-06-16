import 'package:flutter/material.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/screens/activity/components/activity_list_item.dart';
import 'package:twitter_clone/screens/activity/components/activity_type_list_item.dart';
import 'package:twitter_clone/tests/mock.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Activity",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            children: ActivityType.values
                .map(
                  (value) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: ActivityTypeListItem(
                      type: value,
                      isSelected: false,
                      onTap: () => {},
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: ActivityMock.testActivitys.length,
          itemBuilder: (context, index) {
            final activity = ActivityMock.testActivitys[index];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  bottom: 10,
                ),
                child: ActivityListItem(activity: activity),
              ),
            );
          },
        ),
      ],
    );
  }
}
