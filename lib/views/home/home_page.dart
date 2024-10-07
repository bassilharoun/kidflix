import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/views/profile/profile_screen.dart';
import 'package:kidflix_app/views/video_screen/video_player_screen.dart';
import 'package:kidflix_app/widgets/category_item.dart';
import 'package:kidflix_app/widgets/not_subscriped.dart';
import 'package:kidflix_app/widgets/video.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    List<Color> categoriesColors = [
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.yellow,
    ];

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.linearGradiant,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Gap(20.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.categoryResponse!.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            cubit.fetchVideos(
                                "${cubit.categoryResponse!.data[index].id}");
                          },
                          child: CategoryItem(
                            categoryName:
                                cubit.categoryResponse!.data[index].name,
                            categoryImage:
                                cubit.categoryResponse!.data[index].image,
                            categoryColor: AppColors.purble.withOpacity(0.5),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10.w);
                      },
                    ),
                  ),
                ),
                cubit.profileResponse.data!.first.package == null
                    ? SliverToBoxAdapter(
                        child: Padding(
                        padding: EdgeInsets.only(top: 100.h),
                        child: const NotSubscriped(),
                      ))
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              String? videoId =
                                  getVideoId(cubit.videos.videos![index].link);
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
                                    Video(thumbnailUrl: thumbnailUrl),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                            childCount: cubit.videos.videos?.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
