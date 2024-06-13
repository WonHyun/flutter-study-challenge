import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/common/drag_handle.dart';

class PostMoreActionList extends StatelessWidget {
  const PostMoreActionList({
    super.key,
    required this.onTapReport,
  });

  final Function() onTapReport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragHandle(),
          const SizedBox(height: 15),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        onTap: () => {},
                        title: const Text(
                          "Unfollow",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => {},
                        title: const Text(
                          "Mute",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        onTap: () => {},
                        title: const Text(
                          "Hide",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: onTapReport,
                        title: const Text(
                          "Report",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
