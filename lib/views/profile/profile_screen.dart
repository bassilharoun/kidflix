import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/profile/widgets/time_zone_item.dart';
import 'package:kidflix_app/views/editProfile/edit_profile.dart';

class AnimatedProfile extends StatefulWidget {
  final bool isTaped;

  AnimatedProfile({
    required this.isTaped,
  });

  @override
  _AnimatedProfileState createState() => _AnimatedProfileState();
}

class _AnimatedProfileState extends State<AnimatedProfile> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final imgPath = cubit.profileResponse.data![0].userProfile?.image;
    final userName = cubit.profileResponse.data![0].kidName;
    late int _index = 0;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Stack(children: [
          // Background Image Layer
          CachedNetworkImage(
            imageUrl:
                cubit.profileResponse.data!.first.userProfile?.cover ?? "",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/cover_placeholder.png', // Local placeholder image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
          ),

          // Main Content Layer
          Scaffold(
            backgroundColor:
                Colors.transparent, // Makes the scaffold transparent
            body: Stack(
              children: [
                // Hero(
                //   tag: "profilee",
                //   child: CachedNetworkImage(
                //     imageUrl: cubit
                //             .profileResponse.data!.first.userProfile?.cover ??
                //         "https://img.freepik.com/free-photo/3d-cartoon-background-children_23-2150473128.jpg",
                //     fit: BoxFit.cover,
                //     width: double.infinity,
                //     height: double.infinity,
                //     errorWidget: (context, url, error) => Image.asset(
                //       'assets/images/cover_placeholder.png', // Local placeholder image path
                //       fit: BoxFit.cover,
                //       width: double.infinity,
                //       height: double.infinity,
                //     ),
                //     placeholder: (context, url) => Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   ),
                //   // Container(
                //   //   child: Image.network(
                //   //     cubit.profileResponse.data!.first.userProfile?.cover ??
                //   //         "https://img.freepik.com/free-photo/3d-cartoon-background-children_23-2150473128.jpg",
                //   //     fit: BoxFit.cover,
                //   //     width: double.infinity,
                //   //     height: double.infinity,
                //   //   ),
                //   // ),
                // ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: 20,
                  child: Hero(
                    tag: "profile",
                    child: Container(
                      width: 100.sp,
                      height: 100.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.sp)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.sp),
                        child: CachedNetworkImage(
                          imageUrl: imgPath ??
                              "https://img.freepik.com/premium-vector/cute-boy-smiling-cartoon-kawaii-boy-illustration-boy-avatar-happy-kid_1001605-3453.jpg",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/profile_placeholder.png', // Local placeholder image path
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.22,
                  left: 20,
                  child: Text(
                    cubit.profileResponse.data!.first.kidName,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: 20,
                  child: Hero(
                    tag: 'txtL' + userName,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        cubit.profileResponse.data!.first.pFirstName,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: 25,
                  child: Hero(
                    tag: 'userName' + userName,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        cubit.profileResponse.data!.first.email,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  left: 25,
                  child: Row(
                    children: [
                      Hero(
                        tag: 'loc' + userName,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 5),
                      Hero(
                        tag: 'location' + userName,
                        child: Text(
                          cubit.profileResponse.data!.first.country,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: 25,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: 'camera' + userName,
                        child: Icon(
                          Icons.cake,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 5),
                      Hero(
                        tag: 'website' + userName,
                        child: Text(
                          DateTime.parse(
                                  "${cubit.profileResponse.data?.first.birthdate}")
                              .toIso8601String()
                              .substring(0, 10),
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    actions: [
                      IconButton(
                          onPressed: () {
                            debugPrint("Edit Profile");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ],
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        return Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.560,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Hero(
                    tag: 'container' + userName,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, right: 8),
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                // mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Text(
                                      '${getLang(context, "time")}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  // Container(
                                  //   child: Text(
                                  //     'Cards',
                                  //     style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.grey,
                                  //       decoration: TextDecoration.none,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${getLang(context, "addTimeZone")}",
                                          style: AppStyles.style16Medium(
                                              FontFamily.FIGTREE),
                                        ),
                                        Gap(10.w),
                                        CircleAvatar(
                                          child: IconButton(
                                              onPressed: () {
                                                // show dialog that can add start and end time
                                                showTimeRangeBottomSheet(
                                                    context);
                                              },
                                              icon: Icon(
                                                Icons.add_alarm,
                                                color: AppColors.purble,
                                              )),
                                        )
                                      ],
                                    ),
                                    // Gap(10.h),
                                    Expanded(
                                      // height: 100.h,
                                      child: ListView.separated(
                                        itemCount: cubit.profileResponse.data!
                                            .first.userTimeActive.length,
                                        itemBuilder: (context, index) {
                                          return TimeZoneItem(
                                              userTimeActive: cubit
                                                  .profileResponse
                                                  .data!
                                                  .first
                                                  .userTimeActive[index]);
                                        },
                                        separatorBuilder: (context, index) {
                                          return Gap(5.h);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
      },
    );
  }
}
