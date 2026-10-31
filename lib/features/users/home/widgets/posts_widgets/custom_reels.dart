import 'package:alpha/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/widgets/app_animations.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class CustomReels extends StatefulWidget {
  const CustomReels({super.key});

  @override
  State<CustomReels> createState() => _CustomReelsState();
}

class _CustomReelsState extends State<CustomReels> {
  late List<VideoPlayerController?> _controllers;
  late List<bool> _isLoading;
  late List<String?> _errors;

  final Set<int> _initializing = {};
  final List<String> videoUrls = [
    'https://unityworks-a.akamaihd.net/anon.unityworks/7/8/I/61051580_20260105053251UTC_2.mp4',
    'https://unityworks-a.akamaihd.net/anon.unityworks/2/T/8/60189142_20260105150524UTC_2.mp4',
    'https://unityworks-a.akamaihd.net/anon.unityworks/K/1/N/58039179_20260105222013UTC_2.mp4',
    'https://unityworks-a.akamaihd.net/anon.unityworks/C/F/7/60504558_20260105151251UTC_2.mp4',
    'https://unityworks-a.akamaihd.net/anon.unityworks/D/B/X/60462288_20260105032130UTC_2.mp4',
  ];
  int playIndex = -1;

  @override
  void initState() {
    _controllers = List.filled(videoUrls.length, null);
    _isLoading = List.filled(videoUrls.length, true);
    _errors = List.filled(videoUrls.length, null);
    super.initState();
  }

  Future<void> initializeVideo(int index) async {
    if (_controllers[index] != null || _initializing.contains(index)) {
      return;
    }

    _initializing.add(index);

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrls[index]),
    );

    _controllers[index] = controller;

    try {
      await controller.initialize();
      await controller.setLooping(true);

      if (!mounted) return;

      setState(() {
        _isLoading[index] = false;
      });
    } catch (e) {
      debugPrint('Video $index error: $e');

      if (!mounted) return;

      setState(() {
        _isLoading[index] = false;
        _errors[index] = 'Unable to load video';
      });
    } finally {
      _initializing.remove(index);
    }
  }

  Future<void> playReel(int index) async {
    final controller = _controllers[index];
    if (controller == null || !controller.value.isInitialized) return;

    if (playIndex == index) {
      if (controller.value.isPlaying) {
        await controller.pause();
      } else {
        await controller.play();
      }
    } else {
      final previousController = playIndex >= 0
          ? _controllers[playIndex]
          : null;
      if (previousController != null) {
        await previousController.pause();
        await previousController.seekTo(Duration.zero);
      }

      playIndex = index;

      await controller.play();
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  top: 20.h,
                  text: 'ALPHA REELS',
                  size: 14.sp,
                  color: Colors.grey,
                  family: FontFamily.tajawalBold,
                  bottom: 8.h,
                  start: 16.w,
                ),
                AppText(
                  text: 'Ideas in motion',
                  size: 20.sp,
                  family: FontFamily.tajawalBold,
                  bottom: 15.h,
                  start: 16.w,
                ),
              ],
            ),
            Spacer(),
            AppText(
              text: 'Watch all',
              size: 12.sp,
              color: Colors.deepPurple,
              end: 16.w,
            ),
          ],
        ),
        SizedBox(
          height: 300.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              initializeVideo(index);
              final controller = _controllers[index];
              if (_isLoading[index]) {
                return CustomShimmer(
                  child: Container(
                    height: 300.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              }
              if (_errors[index] != null) {
                return Container(
                  height: 300.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: FadeInText(
                      text: "${_errors[index]}",
                      size: 16.sp,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      family: FontFamily.tajawalBold,
                    ),
                  ),
                );
              }
              if (controller == null || !controller.value.isInitialized) {
                return CustomShimmer(
                  child: Container(
                    height: 300.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              }
              return Stack(
                children: [
                  SizedBox(
                    height: 300.h,
                    width: 200.w,
                    child: ClipRect(
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: controller.value.size.width,
                              height: controller.value.size.height,
                              child: VideoPlayer(controller),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: PositionedDirectional(
                      end: 20.w,
                      top: 260.h,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(500.r),
                            child: Image.asset(
                              Assets.img.img.path,
                              height: 60.w,
                              width: 60.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40.sp,
                              ),
                              AppText(
                                text: '20,7k',
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Column(
                            children: [
                              Icon(Icons.comment, size: 40.sp),
                              AppText(
                                text: '20,7k',
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),

                          Column(
                            children: [
                              Icon(Icons.share, size: 40.sp),
                              AppText(
                                text: '20,7k',
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),

                          Icon(Icons.music_video, size: 40.sp),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,

                    child: PositionedDirectional(
                      bottom: 20.h,
                      start: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: AppText(
                              text: '@MohemdRomana',
                              size: 18.sp,
                              color: Colors.white,
                              family: FontFamily.tajawalBold,
                            ),
                          ),
                          SizedBox(
                            width: 250.w,
                            child: AppText(
                              text:
                                  'This document describes how to distribute APK builds to testers using fastlane, an open source platform that automates building and releasing iOS and Android apps. This document follows instructions defined in a Fastfile. After you set up fastlane and your Fastfile, you can integrate App Distribution with your fastlane configuration.',
                              lines: 5,
                              size: 14.sp,
                              color: Colors.grey[300],
                              family: FontFamily.tajawalMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,

                    child: PositionedDirectional(
                      top: 20.h,
                      start: 20.w,
                      child: GestureDetector(
                        onTap: () => playReel(index),
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(
                            playIndex == index && controller.value.isPlaying
                                ? Icons.pause_outlined
                                : Icons.play_arrow_outlined,
                            size: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
