import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/providers.dart';

class PostingView extends StatefulWidget {
  const PostingView({
    super.key,
  });

  @override
  State<PostingView> createState() => _PostingViewState();
}

class _PostingViewState extends State<PostingView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Expanded(
          child: IntrinsicHeight(
            child: Consumer(builder: (context, ref, child) {
              final userState = ref.watch(userInfoProvider);
              final postingNotifier = ref.watch(postingProvider.notifier);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        foregroundImage: NetworkImage(
                          userState.userInfo.userImgPath ?? "",
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 15,
                        foregroundImage: NetworkImage(
                          userState.userInfo.userImgPath ?? "",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userState.userInfo.userId,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextField(
                          controller: _controller,
                          maxLines: null,
                          onChanged: postingNotifier.updateContent,
                          decoration: InputDecoration(
                            hintText: "Start a thread...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {},
                          child: FaIcon(
                            FontAwesomeIcons.paperclip,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
