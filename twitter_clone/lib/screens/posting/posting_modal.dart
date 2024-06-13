import 'package:flutter/material.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_modal_app_bar.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_modal_bottom_panel.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_view.dart';

class PostingModal extends StatefulWidget {
  const PostingModal({
    super.key,
  });

  @override
  State<PostingModal> createState() => _PostingModalState();
}

class _PostingModalState extends State<PostingModal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: context.deviceHeight * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: PostingModalAppBar(),
            ),
            Divider(
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
              thickness: 0.5,
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: Stack(
                children: [
                  PostingView(),
                  PostingModalBottomPanel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
