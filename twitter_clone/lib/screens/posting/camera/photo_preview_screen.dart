import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/providers/notifiers/posting_notifier.dart';
import 'package:twitter_clone/util/generate_util.dart';

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({
    super.key,
    required this.photo,
  });

  final XFile photo;

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  bool _isSaved = false;

  Future<void> _saveToGallery() async {
    if (_isSaved) return;

    await ImageGallerySaver.saveImage(
      await widget.photo.readAsBytes(),
      quality: 100,
    );

    setState(() {
      _isSaved = true;
    });
  }

  void _onSelectPhoto(BuildContext context, WidgetRef ref) {
    final postingNotifier = ref.read(postingProvider.notifier);
    postingNotifier.addMedias(
      [
        MediaItem(
          type: MediaType.image,
          mediaId: uuid.v4(),
          url: "",
          fileUrl: widget.photo.path,
        ),
      ],
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(widget.photo.path),
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    return IconButton(
                      onPressed: () => _onSelectPhoto(context, ref),
                      icon: const FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    );
                  }),
                  if (!_isSaved)
                    IconButton(
                      onPressed: _saveToGallery,
                      icon: const FaIcon(
                        FontAwesomeIcons.download,
                        color: Colors.white,
                        size: 20,
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
