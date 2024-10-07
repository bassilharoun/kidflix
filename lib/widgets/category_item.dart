import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/styles/styles.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final Color categoryColor;
  const CategoryItem(
      {super.key,
      required this.categoryName,
      required this.categoryImage,
      required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          height: 45.sp,
          width: 45.sp,
          child: Padding(
            padding: EdgeInsets.all(2.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.sp),
                child: Image.network(
                  categoryImage,
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
