import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/styles/color.dart';

class Video extends StatelessWidget {
  String thumbnailUrl;
  double height;
  Video({required this.thumbnailUrl, this.height = 170});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // play button
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.play_arrow,
                color: AppColors.purble,
                size: height / 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
