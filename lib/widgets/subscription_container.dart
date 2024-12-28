import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/domain/models/package_model.dart';

class SubscriptionContainer extends StatelessWidget {
  final Package package;
  final int index;
  final bool isSelected;
  SubscriptionContainer(this.package, this.index, this.isSelected);

  final List<String> images = [
    "assets/images/5-7.png",
    "assets/images/3-5.png",
    "assets/images/7-12.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 130.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              image: package.image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(package.image!),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(images[index]),
                    ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 130),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${package.ageFrom} - ${package.ageTo} ${getLang(context, "years")}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // monthly

                        Text(
                          '\$${package.plans[0].price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '\\${getLang(context, "monthly")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // yearly
                        Text(
                          '\$${package.plans[1].price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '\\${getLang(context, "yearly")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // price
          // Positioned(
          //   left: 0,
          //   top: 0,
          //   child: Container(
          //     height: 130.h,
          //     width: 130.w,
          //     decoration: BoxDecoration(
          //       color: AppColors.mix.withOpacity(0.8),
          //       borderRadius: const BorderRadius.only(
          //         topRight: Radius.circular(12),
          //         bottomRight: Radius.circular(12),
          //       ),
          //     ),
          //     child: Center(
          //       child:
          //     ),
          //   ),
          // ),

          // check button this is the selected package

          isSelected
              ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
