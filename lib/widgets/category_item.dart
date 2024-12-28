import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final Color categoryColor;
  final double height;
  const CategoryItem(
      {super.key,
      required this.categoryName,
      required this.categoryImage,
      required this.categoryColor,
      this.height = 55});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: BorderRadius.circular(14.sp),
          ),
          height: height.sp,
          // width: 55.sp,
          child: Padding(
            padding: EdgeInsets.all(2.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.sp),
                child: CachedNetworkImage(
                  imageUrl: categoryImage,
                  fit: BoxFit.cover,
                  height: height.sp,
                  width: height.sp,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported,
                      color: AppColors.purble.withAlpha(100),
                      size: 30.sp),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          categoryName,
          style: AppStyles.style12Regular(FontFamily.FIGTREE).copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
