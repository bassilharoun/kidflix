import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';
import 'package:kidflix_app/widgets/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // AutoPlay the video when the screen is opened
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: KidflixLogo(),
      ),
      body: CustomScrollView(
        slivers: [
          // Gap(15.h),
          SliverToBoxAdapter(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
          SliverToBoxAdapter(child: Gap(15.h)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  String? videoId =
                      getVideoId(cubit.videos!.videos![index].link);
                  if (videoId == null)
                    return Container(); // If video ID is null, return empty

                  String thumbnailUrl = getThumbnailUrl(videoId);

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the video player screen when a video is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerScreen(videoId: videoId),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        // Display video thumbnail
                        Row(
                          children: [
                            Container(
                                width: 120.w,
                                child: Video(
                                  thumbnailUrl: thumbnailUrl,
                                  height: 60,
                                )),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                cubit.videos.videos![index].link,
                                style: AppStyles.style10Regular(
                                    FontFamily.FIGTREE),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
                childCount: cubit.videos?.videos?.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
