import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/lang_cubit.dart';
import 'package:kidflix_app/app/app_cubit/time_check_cubit.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/helpers/cache_helper.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/views/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(KidFlixApp());
}

class KidFlixApp extends StatelessWidget {
  KidFlixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppCubit(),
            ),
            BlocProvider(
              create: (context) => TimeCheckCubit(),
            ),
            BlocProvider(
              create: (context) => LangCubit(),
            ),
          ],
          child: BlocBuilder<LangCubit, Locale>(
            builder: (context, locale) {
              Widget startW = OnboardingScreen();
              return MaterialApp(
                home: startW,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocale.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale("ar", ""),
                  Locale("en", ""),
                ],
                locale: locale.languageCode == "not"
                    ? null
                    : locale, // Updated to use cubit locale
                localeResolutionCallback: (currentLang, supportLang) {
                  if (currentLang != null) {
                    for (Locale locale in supportLang) {
                      if (locale.languageCode == currentLang.languageCode) {
                        print(currentLang.languageCode);
                        return currentLang;
                      }
                    }
                  }
                  return supportLang.first;
                },
              );
            },
          ),
        );
      },
    );
  }
}
