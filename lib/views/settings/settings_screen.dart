import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/editProfile/edit_profile.dart';
import 'package:kidflix_app/views/onboarding/onboarding_screen.dart';
import 'package:kidflix_app/views/profile/profile_screen.dart';
import 'package:kidflix_app/views/settings/terms_screen.dart';
import 'package:kidflix_app/views/subscription/subscription.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final imgPath = cubit.profileResponse.data![0].userProfile?.image;
    final userName = cubit.profileResponse.data![0].kidName;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     "Settings",
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          // ),
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                // User card with profile picture and edit option
                BigUserCard(
                  backgroundColor: AppColors.purble,
                  userName: userName,
                  userProfilePic: NetworkImage(imgPath ?? ""),
                  cardActionWidget: SettingsItem(
                    icons: Icons.edit,
                    iconStyle: IconStyle(
                      withBackground: true,
                      borderRadius: 50,
                      backgroundColor: Colors.yellow[600],
                    ),
                    title: "Modify",
                    subtitle: "Tap to change your data",
                    subtitleStyle: AppStyles.style12Regular(FontFamily.FIGTREE),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    ),
                  ),
                ),
                // Settings group for main options
                SettingsGroup(
                  backgroundColor: Colors.white,
                  items: [
                    SettingsItem(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimatedProfile(
                                  isTaped: true,
                                )),
                      ),
                      icons: CupertinoIcons.person,
                      iconStyle:
                          IconStyle(backgroundColor: ColorStatus.successDark),
                      title: "${getLang(context, "settings")}",
                    ),
                    SettingsItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubscriptionScreen()),
                        );
                      },
                      icons: CupertinoIcons.money_pound,
                      iconStyle:
                          IconStyle(backgroundColor: ColorStatus.errorDark),
                      title: "${getLang(context, "subscription")}",
                    ),
                  ],
                ),
                SettingsGroup(
                  backgroundColor: ColorNeutrals.white,
                  settingsGroupTitle: "Support",
                  items: [
                    SettingsItem(
                      onTap: () async {
                        var whatsappUrl = "whatsapp://send?phone=+201017751629";
                        await canLaunch(whatsappUrl)
                            ? launch(whatsappUrl)
                            : showToast(
                                text: "تعذر الوصول لتطبيق واتساب",
                                state: ToastStates.ERROR,
                              );
                      },
                      icons: Icons.support_agent,
                      iconStyle: IconStyle(),
                      title: "${getLang(context, "contactUs")}",
                    ),
                    SettingsItem(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsScreen()),
                      ),
                      icons: Icons.checklist_outlined,
                      iconStyle: IconStyle(),
                      title: "${getLang(context, "privacy")}",
                    ),
                  ],
                ),
                // Account settings group with logout option
                SettingsGroup(
                  backgroundColor: ColorNeutrals.white,
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingScreen(),
                          ),
                        );
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "${getLang(context, "signOut")}",
                      titleStyle: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
