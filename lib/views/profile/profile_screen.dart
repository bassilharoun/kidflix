import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';

class AnimatedProfile extends StatefulWidget {
  final bool isTaped;

  AnimatedProfile({
    required this.isTaped,
  });

  @override
  _AnimatedProfileState createState() => _AnimatedProfileState();
}

class _AnimatedProfileState extends State<AnimatedProfile> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final imgPath = cubit.profileResponse.data![0].userProfile?.image;
    final userName = cubit.profileResponse.data![0].kidName;
    late int _index = 0;

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "${cubit.profileResponse.data!.first.userProfile?.cover}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Hero(
              tag: "profilee",
              child: Container(
                child: Image.network(
                  "${cubit.profileResponse.data!.first.userProfile?.cover}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.11,
              left: 20,
              child: Hero(
                tag: "profile",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgPath!),
                  backgroundColor: Colors.grey,
                  radius: 40,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: 20,
              child: Hero(
                tag: 'txtF' + userName,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    cubit.profileResponse.data!.first.kidName,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 20,
              child: Hero(
                tag: 'txtL' + userName,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    cubit.profileResponse.data!.first.pFirstName,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: 25,
              child: Hero(
                tag: 'userName' + userName,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    cubit.profileResponse.data!.first.email,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 25,
              child: Row(
                children: [
                  Hero(
                    tag: 'loc' + userName,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 5),
                  Hero(
                    tag: 'location' + userName,
                    child: Text(
                      cubit.profileResponse.data!.first.country,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 25,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'camera' + userName,
                    child: Icon(
                      Icons.cake,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 5),
                  Hero(
                    tag: 'website' + userName,
                    child: Text(
                      DateTime.parse(
                              "${cubit.profileResponse.data?.first.birthdate}")
                          .toIso8601String()
                          .substring(0, 10),
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.560,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: 'container' + userName,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 8),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Info',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Cards',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add time zone",
                                      style: AppStyles.style16Medium(
                                          FontFamily.FIGTREE),
                                    ),
                                    Gap(10.w),
                                    CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add_alarm,
                                            color: AppColors.purble,
                                          )),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
