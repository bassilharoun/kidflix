import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/styles/color.dart';

class UserCard extends StatelessWidget {
  UserCard(
      {super.key,
      required this.userProfilePic,
      required this.userName,
      required this.cardActionWidget});
  String userProfilePic;
  String userName;
  Widget cardActionWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.purble,
      ),
      width: double.infinity,
      height: 170.h,
      child: Column(
        children: [
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: NetworkImage(
                  userProfilePic,
                ),
              ),
              Gap(20.w),
              Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          Gap(10.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 50.h,
              child: cardActionWidget,
            ),
          )
        ],
      ),
    );
  }
}
