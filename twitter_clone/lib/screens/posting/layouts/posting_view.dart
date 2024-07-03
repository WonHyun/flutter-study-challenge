import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/image_item.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/posting/camera/camera_screen.dart';

class PostingView extends StatefulWidget {
  const PostingView({
    super.key,
  });

  @override
  State<PostingView> createState() => _PostingViewState();
}

class _PostingViewState extends State<PostingView> {
  final TextEditingController _controller = TextEditingController();

  void _openCameraScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

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
        child: IntrinsicHeight(
          child: Consumer(builder: (context, ref, child) {
            final userState = ref.watch(userInfoProvider);
            final postingState = ref.watch(postingProvider);
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
                        userState.userInfo.avatarPath ?? "",
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: VerticalDivider(
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.5),
                          thickness: 1.5,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      foregroundImage: NetworkImage(
                        userState.userInfo.avatarPath ?? "",
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
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userState.userInfo.userId,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            if (postingState.post.content.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  postingNotifier.clearContent();
                                  _controller.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: FaIcon(
                                    FontAwesomeIcons.x,
                                    color: Colors.grey.shade500,
                                    size: 14,
                                  ),
                                ),
                              ),
                          ],
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
                      if (postingState.post.media != null &&
                          postingState.post.media!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: postingState.post.media!.length,
                              itemBuilder: (context, index) {
                                final media = postingState.post.media![index];
                                if (media is ImageItem) {
                                  if (media.url.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.file(
                                              File(media.filePath),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: GestureDetector(
                                              onTap: () => postingNotifier
                                                  .removeMedia(media),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                child: const FaIcon(
                                                  FontAwesomeIcons.x,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Image.network(media.url);
                                  }
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: _openCameraScreen,
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
    );
  }
}
