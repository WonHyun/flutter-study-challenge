import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/value.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/common/drag_handle.dart';

class PostMoreActionModal extends StatefulWidget {
  const PostMoreActionModal({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostMoreActionModal> createState() => _PostMoreActionModalState();
}

class _PostMoreActionModalState extends State<PostMoreActionModal> {
  bool _isReportScreen = false;

  void _goToReportAction() {
    setState(() {
      _isReportScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: Builder(builder: (context) {
        if (_isReportScreen) {
          return PostReportModal(post: widget.post);
        } else {
          return PostMoreActionList(onTapReport: _goToReportAction);
        }
      }),
    );
  }
}

class PostReportModal extends StatelessWidget {
  const PostReportModal({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragHandle(),
          const SizedBox(height: 20),
          const Text(
            "Report",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Why are you reporting this thread?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: postReportReasons.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    onTap: () => {},
                    title: Text(postReportReasons[index]),
                    trailing: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .inverseSurface
                          .withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
