import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/value.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/drag_handle.dart';

class PostReportModal extends ConsumerWidget {
  const PostReportModal({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postNotifier = ref.watch(postProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
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
            height: 200,
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
                    onTap: () {
                      postNotifier.reportPost(post, postReportReasons[index]);
                      Navigator.pop(context);
                    },
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
