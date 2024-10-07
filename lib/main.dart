import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/views/onboarding/onboarding_screen.dart';

void main() {
  runApp(const kidFlixApp());
}

class kidFlixApp extends StatelessWidget {
  const kidFlixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppCubit(),
            ),
          ],
          child: MaterialApp(
            home: OnboardingScreen(),
          ),
        );
      },
    );
  }
}
