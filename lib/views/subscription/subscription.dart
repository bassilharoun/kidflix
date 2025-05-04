import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/subscription_container.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.mix,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(15.h),
                    Text(
                      '${getLang(context, "subscription")}',
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
                          ? 'pay now'
                          : '${getLang(context, "alreadySubscribed")}',
                      onPressed: cubit.profileResponse.data!.first.package ==
                              null
                          ? () async {
                              if (cubit.selectedPackage != -1) {
                                await showAddPasswordDialog(context, () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaypalCheckoutView(
                                      sandboxMode: true,
                                      clientId:
                                          "AXpWwEJQzzi6V9U7vXhxpFzL6I0wbngqnrYl47dLMtSk5VZD4kd_yJoV4OjNcPhDxs4lVUWlxwi_p4TW",
                                      secretKey:
                                          "EGm-w_vdM8He6U-N852KGaUdDGuj7cJw16zFlNSnWFBCQMbk7aKfx3Pg4ic5ztTIYQQMpPoAS_MfZlkm",
                                      transactions: [
                                        {
                                          "amount": {
                                            "total": cubit
                                                .packageResponse!
                                                .data[cubit.selectedPackage]
                                                .plans[0]
                                                .price
                                                .toStringAsFixed(2),
                                            "currency": "USD",
                                            "details": {
                                              "subtotal": cubit
                                                  .packageResponse!
                                                  .data[cubit.selectedPackage]
                                                  .plans[0]
                                                  .price
                                                  .toStringAsFixed(2),
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description":
                                              "The payment transaction description.",
                                          // "payment_options": {
                                          //   "allowed_payment_method":
                                          //       "INSTANT_FUNDING_SOURCE"
                                          // },
                                          "item_list": {
                                            "items": [
                                              {
                                                "name": cubit
                                                    .packageResponse!
                                                    .data[cubit.selectedPackage]
                                                    .name,
                                                "quantity": 1,
                                                "price": cubit
                                                    .packageResponse!
                                                    .data[cubit.selectedPackage]
                                                    .plans[0]
                                                    .price
                                                    .toStringAsFixed(2),
                                                "currency": "USD"
                                              },
                                            ],
                                          }
                                        }
                                      ],
                                      note:
                                          "Contact us for any questions on your order.",
                                      onSuccess: (Map params) async {
                                        debugPrint("onSuccess: $params");
                                        cubit.subscribe(
                                            cubit.packageResponse!
                                                .data[cubit.selectedPackage].id,
                                            cubit
                                                .packageResponse!
                                                .data[cubit.selectedPackage]
                                                .plans[0]
                                                .id,
                                            context,
                                            cubit.accessCode,
                                            "demoTransactionId");
                                      },
                                      onError: (error) {
                                        debugPrint("onError: $error");
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        debugPrint('cancelled:');
                                      },
                                    ),
                                  ));
                                });
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
