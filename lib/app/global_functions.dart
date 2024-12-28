// Method to extract YouTube video ID from URL
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String? getVideoId(String url) {
  return YoutubePlayer.convertUrlToId(url);
}

// Method to get thumbnail URL using the video ID
String getThumbnailUrl(String videoId) {
  return 'https://img.youtube.com/vi/$videoId/0.jpg'; // Thumbnail URL pattern
}

void showLoadingDialog(BuildContext context, AnimationController _controller) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Lottie.asset(
        height: 180.h,
        'assets/images/loading2.json',
        controller: _controller,
        onLoaded: (composition) {
          // Configure the AnimationController with the duration of the Lottie file and start the animation.
          _controller
            ..duration = composition.duration
            ..repeat(); // Loop the animation if needed
        },
      ),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context); // Pop the dialog when not loading anymore
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

Future<void> showTimeRangeBottomSheet(BuildContext context) async {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) {
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${getLang(context, "selectTimeRange")}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        title: Text(
                            '${getLang(context, "startTime")}: ${startTime?.format(context) ?? 'Not set'}'),
                        trailing: Icon(Icons.access_time),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              startTime = picked;
                            });
                          }
                        },
                      ),
                      ListTile(
                        title: Text(
                            '${getLang(context, "endTime")}: ${endTime?.format(context) ?? 'Not set'}'),
                        trailing: Icon(Icons.access_time),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: startTime ?? TimeOfDay.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              endTime = picked;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('${getLang(context, "cancel")}'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: AppCubit.get(context).accessCode == ''
                                ? () async {
                                    if (startTime != null && endTime != null) {
                                      // Save or perform action with selected times
                                      showAddPasswordDialog(context, () async {
                                        await AppCubit.get(context)
                                            .addUserTimeActive(
                                                formatTimeOfDay(startTime!),
                                                formatTimeOfDay(endTime!),
                                                AppCubit.get(context)
                                                    .accessCode,
                                                context);
                                      });
                                    }
                                  }
                                : () async {
                                    await AppCubit.get(context)
                                        .addUserTimeActive(
                                            formatTimeOfDay(startTime!),
                                            formatTimeOfDay(endTime!),
                                            AppCubit.get(context).accessCode,
                                            context);
                                    Navigator.of(context).pop();
                                  },
                            child: AppCubit.get(context).accessCode != ''
                                ? Text('${getLang(context, "save")}')
                                : Text('${getLang(context, "addPassword")}'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

// show add password dialog
Future<void> showAddPasswordDialog(
    BuildContext context, Function function) async {
  TextEditingController passwordController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('${getLang(context, "addPassword")}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: passwordController,
              labelText: '${getLang(context, "password")}',
              hintText: '********',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.purble,
              ),
              isObsecure: true,
              canUnObsecure: true,
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('${getLang(context, "cancel")}'),
          ),
          TextButton(
            onPressed: () async {
              // Save or perform action with entered password
              await AppCubit.get(context)
                  .checkPassword(passwordController.text, context)
                  .then((value) async {
                function();
                // Navigator.of(context).pop();
              });
            },
            child: Text('${getLang(context, "save")}'),
          ),
        ],
      );
    },
  );
}

// show status snackbar
void showStatusSnackBar(BuildContext context, String message, bool success) {
  // Check if the context is still mounted
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}


enum ToastStates{SUCCESS , ERROR , WARNING}
Color? chooseToastColor(ToastStates state){
  Color? color ;
  switch(state){
    case ToastStates.SUCCESS:
      color = AppColors.purble;
      break;
    case ToastStates.ERROR:
      color = Colors.redAccent;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color ;

}
void showToast({
  required String text ,
  required ToastStates state ,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);