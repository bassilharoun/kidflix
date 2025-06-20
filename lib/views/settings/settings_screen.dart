import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/helpers/cache_helper.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/editProfile/edit_profile.dart';
import 'package:kidflix_app/views/onboarding/onboarding_screen.dart';
import 'package:kidflix_app/views/profile/profile_screen.dart';
import 'package:kidflix_app/views/settings/terms_screen.dart';
import 'package:kidflix_app/views/settings/widgets/settings_group.dart';
import 'package:kidflix_app/views/settings/widgets/settings_item.dart';
import 'package:kidflix_app/views/settings/widgets/user_card.dart';
import 'package:kidflix_app/views/subscription/subscription.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    String? imgPath = "https://img.freepik.com/premium-vector/cute-boy-smiling-cartoon-kawaii-boy-illustration-boy-avatar-happy-kid_1001605-3453.jpg";
        String userName = "";

    if (cubit.profileResponse.data!.isNotEmpty){
      imgPath = cubit.profileResponse.data![0].userProfile?.image;
      userName = cubit.profileResponse.data![0].kidName;
    }

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
                UserCard(
                  userName: userName,
                  userProfilePic: imgPath!,
                  cardActionWidget: SettingsItem(
                    icons: Icons.edit,
                    iconColor: Colors.yellow,
                    
                    title: "Modify",
                    subtitle: "Tap to change your data",
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
                  settingsGroupTitle: "Main",
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
                      iconColor: Colors.blue,
                      title: "${getLang(context, "settings")}",
                      subtitle: "Manage your account",
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
                      iconColor: Colors.green,
                      title: "${getLang(context, "subscription")}",
                      subtitle: "Upgrade your plan",
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
                      iconColor: Colors.green,
                      title: "${getLang(context, "contactUs")}",
                      subtitle: "Chat with us",
                    ),
                    SettingsItem(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsScreen()),
                      ),
                      icons: Icons.checklist_outlined,
                      iconColor: Colors.blue,
                      title: "${getLang(context, "privacy")}",
                      subtitle: "Terms and conditions",
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
                        CacheHelper.removeData(key: "user_token");
                      },
                      icons: Icons.exit_to_app_rounded,
                      iconColor: Colors.red,
                      title: "${getLang(context, "signOut")}",
                      subtitle: "Logout from your account",
                    ),
                  ],
                ),
              ],
              // children: [],
            ),
          ),
        );
      },
    );
  }
}
