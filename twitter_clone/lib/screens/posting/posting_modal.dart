import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/notifiers/posting_notifier.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_modal_app_bar.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_modal_bottom_panel.dart';
import 'package:twitter_clone/screens/posting/layouts/posting_view.dart';

class PostingModal extends ConsumerWidget {
  const PostingModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        GestureDetector(
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
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.2),
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
        ),
        if (ref.watch(postingProvider).isLoading)
          Container(
            width: double.infinity,
            height: context.deviceHeight * 0.9,
            color: Colors.black.withOpacity(0.1),
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive(),
          )
      ],
    );
  }
}
