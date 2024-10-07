import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/subscription_container.dart';

class Subscription extends StatelessWidget {
  Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is KidSubscribeSuccessState) {
          tabControllerHomeShared.animateTo(0);
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          // decoration: const BoxDecoration(gradient: AppColors.linearGradiant),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(15.h),
                    const Text(
                      'Subscribtion',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mix,
                      ),
                    ),
                    Gap(10.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.packageResponse!.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            cubit.changeSelectedPackage(index);
                          },
                          child: SubscriptionContainer(
                            cubit.packageResponse!.data[index],
                            index,
                            cubit.selectedPackage == index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gap(15.h);
                      },
                    ),
                    Gap(15.h),
                    // const SubscriptionContainer("assets/images/3-5.png", "3-5"),
                    // Gap(15.h),
                    // const SubscriptionContainer('assets/images/5-7.png', "5-7"),
                    // Gap(15.h),
                    // const SubscriptionContainer('assets/images/7-12.png', "7-12"),
                    // Gap(15.h),
                    CustomButton(
                      data: cubit.profileResponse.data!.first.package == null
                          ? 'Subscribe'
                          : 'Already Subscribed',
                      onPressed: cubit.profileResponse.data!.first.package ==
                              null
                          ? () {
                              if (cubit.selectedPackage != -1) {
                                cubit.subscribe(
                                    cubit.packageResponse!
                                        .data[cubit.selectedPackage].id,
                                    cubit
                                        .packageResponse!
                                        .data[cubit.selectedPackage]
                                        .plans[0]
                                        .id);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select a package'),
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
