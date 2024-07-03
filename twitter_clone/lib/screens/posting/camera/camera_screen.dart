import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/providers/notifiers/posting_notifier.dart';
import 'package:twitter_clone/screens/posting/camera/components/flash_button.dart';
import 'package:twitter_clone/screens/posting/camera/photo_preview_screen.dart';
import 'package:twitter_clone/util/generate_util.dart';

import 'components/shutter_button.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  CameraLensDirection _currentDirection = CameraLensDirection.back;
  FlashMode _flashMode = FlashMode.off;

  bool _isNoCameraMode = false;

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _isNoCameraMode = true;
        });
        return;
      }

      final selectedCamera = cameras
          .where((camera) => camera.lensDirection == _currentDirection)
          .first;

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.max,
      );
      await _cameraController?.initialize();
      await _cameraController?.setFlashMode(_flashMode);
      setState(() {});
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      setState(() {
        _isNoCameraMode = true;
      });
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null) return;
    final photo = await _cameraController?.takePicture();

    if (mounted) {
      if (photo != null) {
        final isSelectPhoto = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoPreviewScreen(photo: photo),
          ),
        );
        if (isSelectPhoto && mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  Future<void> _toggleFlashMode() async {
    if (_cameraController == null) return;
    switch (_flashMode) {
      case FlashMode.off:
        _flashMode = FlashMode.auto;
      case FlashMode.auto:
        _flashMode = FlashMode.always;
      case FlashMode.always:
        _flashMode = FlashMode.torch;
      case FlashMode.torch:
        _flashMode = FlashMode.off;
    }
    await _cameraController?.setFlashMode(_flashMode);
    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _currentDirection = _currentDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    await initCamera();
  }

  Future<void> _showGallery(WidgetRef ref) async {
    final postingNotifier = ref.read(postingProvider.notifier);
    final photos = await ImagePicker().pickMultiImage();
    if (photos.isNotEmpty && mounted) {
      final medias = photos
          .map((file) => MediaItem(
                type: MediaType.image,
                mediaId: uuid.v4(),
                url: "",
                fileUrl: file.path,
              ))
          .toList();
      postingNotifier.addMedias(medias);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // if (mounted) {
    //   switch (state) {
    //     case AppLifecycleState.paused:
    //       if (_cameraController != null &&
    //           _cameraController!.value.isInitialized) {
    //         await _cameraController!.dispose();
    //         _cameraController = null;
    //       }
    //     case AppLifecycleState.resumed:
    //       if (_cameraController == null) {
    //         await initCamera();
    //       }
    //     default:
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          if (_cameraController == null ||
              !_cameraController!.value.isInitialized) {
            return Stack(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_isNoCameraMode)
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Select Image from Gallery",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) {
                            return IconButton(
                              onPressed: () => _showGallery(ref),
                              icon: const Icon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                else
                  const Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Initializing Camera...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        CircularProgressIndicator.adaptive(strokeWidth: 5),
                      ],
                    ),
                  ),
              ],
            );
          } else {
            return Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: CameraPreview(_cameraController!),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlashButton(
                        flashMode: _flashMode,
                        onPressed: _toggleFlashMode,
                      ),
                      ShutterButton(
                        onTap: _takePhoto,
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: _toggleSelfieMode,
                        icon: const FaIcon(FontAwesomeIcons.repeat, size: 20),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  right: 30,
                  child: Row(
                    children: [
                      const Spacer(),
                      const Expanded(
                        child: Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => _showGallery(ref),
                              child: Text(
                                "Library",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
