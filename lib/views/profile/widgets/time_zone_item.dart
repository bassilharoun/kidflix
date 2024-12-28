import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/domain/models/user_model.dart';

class TimeZoneItem extends StatelessWidget {
  const TimeZoneItem({super.key, required this.userTimeActive});
  final UserTimeActive userTimeActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 12,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "start: ",
                        style: AppStyles.style14Regular(FontFamily.FIGTREE)
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        userTimeActive.start,
                        style: AppStyles.style14Regular(FontFamily.FIGTREE)
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "end: ",
                        style: AppStyles.style14Regular(FontFamily.FIGTREE)
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        userTimeActive.end,
                        style: AppStyles.style14Regular(FontFamily.FIGTREE)
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  showAddPasswordDialog(context, () {
                    AppCubit.get(context).deleteTimeActive(
                        userTimeActive.id.toString(),
                        AppCubit.get(context).accessCode,
                        context);
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
