import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.linearGradiant,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'Categories',
                  style: AppStyles.style18SemiBold(
                    FontFamily.FIGTREE,
                    color: AppColors.purble,
                  ),
                ),
              ),
              Gap(20.h),
              Expanded(
                // Wrap the GridView.builder inside Expanded
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, // You can adjust the number of items per row
                    crossAxisSpacing:
                        10.w, // Adjust the spacing between items horizontally
                    childAspectRatio:
                        1.2, // Adjust the aspect ratio of the items
                  ),
                  itemCount: cubit.categoryResponse!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        cubit
                            .fetchVideos(
                                "${cubit.categoryResponse!.data![index].id}")
                            .then((value) {
                          tabControllerHomeShared.index = 0;
                        });
                      },
                      child: CategoryItem(
                        categoryName: cubit.categoryResponse!.data![index].name,
                        categoryImage:
                            cubit.categoryResponse!.data![index].image,
                        categoryColor: AppColors.purble.withOpacity(0.5),
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
