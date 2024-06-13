import 'package:flutter/material.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home/layouts/post_more_action_list.dart';
import 'package:twitter_clone/screens/home/layouts/post_report_modal.dart';

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
          return PostMoreActionList(
            post: widget.post,
            onTapReport: _goToReportAction,
          );
        }
      }),
    );
  }
}
