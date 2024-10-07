import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KidflixLogo extends StatelessWidget {
  double width;
  KidflixLogo({this.width = 90});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        'assets/images/logo 1.png',
      ),
      width: width.w,
    );
  }
}
