import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/lang_cubit.dart';
import 'package:kidflix_app/app/app_cubit/time_check_cubit.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/domain/models/user_model.dart';
import 'package:kidflix_app/views/categories/categories.dart';
import 'package:kidflix_app/views/home/home_page.dart';
import 'package:kidflix_app/views/payment/payment_method.dart';
import 'package:kidflix_app/views/profile/profile_screen.dart';
import 'package:kidflix_app/views/editProfile/edit_profile.dart';
import 'package:kidflix_app/views/settings/settings_screen.dart';
import 'package:kidflix_app/views/subscription/subscription.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';

late TabController tabControllerHomeShared;

enum MyWidgetTabs { HOME, SUBSCRIPTION, SETTINGS }

late MyWidgetTabs selectedTabEnum;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>
    with SingleTickerProviderStateMixin, RouteAware {
  final String className = "HomeWindow-AppBar";
  var tabBarView;
  var bottomNavigationBar;

  HomeState();

  void _handleTabSelection() {
    setState(() {
      selectedTabEnum = MyWidgetTabs.values[tabControllerHomeShared.index];
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTabs();
    _checkUserAccess();
  }

  void initializeTabs() {
    tabControllerHomeShared = TabController(vsync: this, length: 3);
    tabControllerHomeShared.addListener(_handleTabSelection);
    selectedTabEnum = MyWidgetTabs.HOME;

    tabBarView =
        TabBarView(controller: tabControllerHomeShared, children: <Widget>[
      HomePage(),
      SettingsScreen(),
      CategoriesScreen(),
    ]);
  }

  void _checkUserAccess() {
    // Simulate receiving active times from an API or local source
    // Start checking the access times in the cubit
    BlocProvider.of<TimeCheckCubit>(context).startChecking(
        AppCubit.get(context).profileResponse.data!.first.userTimeActive);
  }

  Widget getBottomNavigationBar() {
    double iconHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      iconHeight = MediaQuery.of(context).size.height * 0.035;
    } else {
      iconHeight = MediaQuery.of(context).size.width * 0.035;
    }

    bottomNavigationBar = BottomAppBar(
        height: 60.h,
        color: Colors.white,
        child: TabBar(
            controller: tabControllerHomeShared,
            indicatorColor: AppColors.purble,
            dividerColor: Colors.transparent,
            labelColor: AppColors.purble,
            unselectedLabelColor: Colors.black,
            tabs: <Tab>[
              Tab(
                  icon: Icon(CupertinoIcons.home,
                      color: tabControllerHomeShared.index == 0
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "${getLang(context, "home")}"),
              Tab(
                  icon: Icon(CupertinoIcons.settings,
                      color: tabControllerHomeShared.index == 1
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "${getLang(context, "settings")}"),
              Tab(
                  icon: Icon(CupertinoIcons.rectangle_3_offgrid,
                      color: tabControllerHomeShared.index == 2
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "${getLang(context, "categories")}"),
            ]));
    return bottomNavigationBar;
  }

  @override
  void dispose() {
    tabControllerHomeShared.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCheckCubit, bool>(
      builder: (context, isAccessible) {
        if (!isAccessible) {
          // Lock Screen if the user is out of the active time
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: KidflixLogo(),
              leadingWidth: 0,
              leading: SizedBox(),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimatedProfile(
                                    isTaped: true,
                                  )));
                    },
                    // child: Hero(

                    //   tag: "profile",
                    //   child: CircleAvatar(
                    //     child: CachedNetworkImage(
                    //         imageUrl: AppCubit.get(context)
                    //                 .profileResponse
                    //                 .data
                    //                 ?.first
                    //                 .userProfile
                    //                 ?.image ??
                    //             "",
                    //         errorWidget: (context, url, error) => Icon(
                    //             Icons.image_not_supported,
                    //             color: AppColors.purble.withAlpha(100),
                    //             size: 30.sp),
                    //         placeholder: (context, url) => const Center(
                    //               child: CircularProgressIndicator(),
                    //             )),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 100, color: Colors.red),
                  SizedBox(height: 20),
                  Text(
                    "Access Denied!",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                  Text(
                    "Your active time has expired.",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }

        // Normal Home screen when accessible
        return Container(
          decoration: const BoxDecoration(
            gradient: AppColors.linearGradiant,
          ),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: KidflixLogo(),
                leadingWidth: 0,
                leading: SizedBox(),
                actions: [
                  InkWell(
                      onTap: () {
                        AppLocale.of(context).locale.languageCode == "ar"
                            ? BlocProvider.of<LangCubit>(context)
                                .changeLanguage('en', context)
                            : BlocProvider.of<LangCubit>(context)
                                .changeLanguage('ar', context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Text(
                            AppLocale.of(context).locale.languageCode == "ar"
                                ? "عربي"
                                : "EN",
                            style: TextStyle(
                                color: AppColors.purble,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnimatedProfile(
                                      isTaped: true,
                                    )));
                      },
                      child: Hero(
                        tag: "profile",
                        child: Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.sp)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.sp),
                            child: CachedNetworkImage(
                              imageUrl: AppCubit.get(context)
                                      .profileResponse
                                      .data
                                      ?.first
                                      .userProfile
                                      ?.image ??
                                  "https://img.freepik.com/premium-vector/cute-boy-smiling-cartoon-kawaii-boy-illustration-boy-avatar-happy-kid_1001605-3453.jpg",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/profile_placeholder.png', // Local placeholder image path
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar:
                  getBottomNavigationBar(), // Add the bottom Navigation Bar
              body: SafeArea(
                child: tabBarView,
              )),
        );
      },
    );
  }
}
