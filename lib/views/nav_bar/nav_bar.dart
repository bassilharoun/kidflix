import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/views/home/home_page.dart';
import 'package:kidflix_app/views/payment/payment_method.dart';
import 'package:kidflix_app/views/profile/profile_screen.dart';
import 'package:kidflix_app/views/settings/settings_screen.dart';
import 'package:kidflix_app/views/subscription/subscription.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';

//import "package:fancy_bottom_navigation/fancy_bottom_navigation.dart";
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
  //------------------------------------------------------------------------------------
  final String className =
      "HomeWindow-AppBar"; //Used for subscribing to chat notfications
  //------------------------------------------------------------------------------------

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
  }

  void initializeTabs() {
    tabControllerHomeShared = TabController(vsync: this, length: 3);
    tabControllerHomeShared.addListener(_handleTabSelection);
    selectedTabEnum = MyWidgetTabs.HOME;

    tabBarView =
        TabBarView(controller: tabControllerHomeShared, children: <Widget>[
      HomePage(),
      Subscription(),
      SettingsScreen(),
    ]);
  }

  Widget getBottomNavigationBar() {
    print('went here in the bottom navigation bar widget');
    double iconHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      iconHeight = MediaQuery.of(context).size.height * 0.035;
    } else {
      iconHeight = MediaQuery.of(context).size.width * 0.035;
    }

    bottomNavigationBar = BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.white,
        // gradient color

        child: TabBar(
            controller: tabControllerHomeShared,
            indicatorColor: Colors.transparent,
            labelColor: AppColors.purble,
            unselectedLabelColor: Colors.black,
            tabs: <Tab>[
              Tab(
                  icon: Icon(CupertinoIcons.home,
                      color: tabControllerHomeShared.index == 0
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "Home"),
              Tab(
                  icon: Icon(CupertinoIcons.money_dollar_circle,
                      color: tabControllerHomeShared.index == 1
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "Subscription"),
              Tab(
                  icon: Icon(CupertinoIcons.settings,
                      color: tabControllerHomeShared.index == 2
                          ? AppColors.purble
                          : Theme.of(context).hintColor),
                  text: "Settings"),
            ]));
    return bottomNavigationBar;
  }

  @override
  void dispose() {
    tabControllerHomeShared.dispose();
    super.dispose();
  }

  //Central place for setstate here
  void refreshState(Function callback) {
    if (mounted) {
      setState(() {
        callback();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.linearGradiant,
      ),
      child: Scaffold(
          appBar: AppBar(
            // floating: true,
            backgroundColor: Colors.white,
            title: KidflixLogo(),
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
                  child: Hero(
                    tag: "profile",
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${AppCubit.get(context).profileResponse.data?.first.userProfile?.image}"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // backgroundColor: AppColors.linearGradiant,
          // gradient

          bottomNavigationBar:
              getBottomNavigationBar(), //Add the bottom Navigation Bar
          body: SafeArea(
            child: tabBarView,
          )),
    );
  }
}
