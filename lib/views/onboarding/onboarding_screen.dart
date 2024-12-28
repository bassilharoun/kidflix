import 'package:flutter/material.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/views/auth/login/login.dart';
import 'package:kidflix_app/views/auth/register/register.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';
import 'package:video_player/video_player.dart'; // Import the video player package

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('assets/videos/onboarding.mp4')
          ..initialize().then((_) {
            setState(() {}); // Ensure video is loaded before rendering
            _videoController.play();
            _videoController.setVolume(0.0);
            _videoController.setLooping(true);
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  String title = "kidflix";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // Get screen size
    List<String> descriptions = [
      "${getLang(context, "on1")}",
      "${getLang(context, "on2")}",
      "${getLang(context, "on3")}",
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize.height, // 60% of screen height for video
            width: double.infinity,
            child: _videoController.value.isInitialized
                ? VideoPlayer(_videoController)
                : Center(child: CircularProgressIndicator()),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 4,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                      // if (index == 2) {
                      //   // When on the last page, navigate to login
                      //   Future.delayed(Duration(seconds: 2), () {
                      //     Navigator.pushReplacement(context,
                      //         MaterialPageRoute(builder: (context) => login()));
                      //   });
                      // }
                    });
                  },
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   title,
                          //   style: TextStyle(
                          //       fontSize: 24,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.white),
                          // ),
                          KidflixLogo(),
                          SizedBox(height: 20),
                          Text(
                            descriptions[index],
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        descriptions.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                    Spacer(),
                    _currentPage != 2
                        ? MaterialButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              "${getLang(context, "next")}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              "${getLang(context, "getStarted")}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          // SafeArea(child: KidflixAppBar()),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 12 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
