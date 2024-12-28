import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/auth/register/register.dart';
import 'package:kidflix_app/views/home/home_page.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/custom_text_button.dart';
import 'package:kidflix_app/widgets/custom_text_field.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is KidLoginLoadingState) {
          showLoadingDialog(context, _controller);
        } else if (state is KidLoginErrorState) {
          hideLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is KidLoginSuccessState) {
          cubit.getPackages();
          cubit.getCategories().then((value) {
            cubit
                .fetchVideos("${cubit.categoryResponse!.data?.first.id}")
                .then((value) {
              cubit.fetchProfile(context).then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                  (Route<dynamic> route) => false,
                );
              });
            });
          });
        }
      },
      builder: (context, state) {
        return Container(
            decoration: const BoxDecoration(
              gradient: AppColors.linearGradiant,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.all(24.sp),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: KidflixLogo(
                        width: 150.w,
                      )),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image(
                          image: AssetImage('assets/images/Login.png'),
                        ),
                      ),
                      Gap(20.h),
                      CustomTextField(
                        controller: emailController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "email is required";
                          } else if (!p0.contains("@") ||
                              !p0.contains(".com")) {
                            return "email is not valid";
                          }
                          return null;
                        },
                        labelText: "${getLang(context, "email")}",
                        hintText: "ex@kidflix.com",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.purble,
                        ),
                      ),
                      Gap(15.h),
                      CustomTextField(
                        controller: passwordController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Password is required";
                          } else if (p0.length < 6) {
                            return "password is not valid";
                          }
                          return null;
                        },
                        labelText: "${getLang(context, "password")}",
                        hintText: "********",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.purble,
                        ),
                        isObsecure: true,
                        canUnObsecure: true,
                      ),
                      Gap(15.h),
                      CustomButton(
                        data: "${getLang(context, "login")}",
                        onPressed: state is! KidLoginLoadingState
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  cubit.login(emailController.text,
                                      passwordController.text, context);
                                }
                              }
                            : null,
                      ),
                      Gap(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${getLang(context, "dontHaveAnAccount")}",
                            style: AppStyles.style14Regular(
                              FontFamily.FIGTREE,
                              color: Colors.black,
                            ).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextButton(
                              text: "${getLang(context, "register")}",
                              style: AppStyles.style16Medium(
                                FontFamily.FIGTREE,
                                color: AppColors.purble,
                              ).copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              })
                        ],
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 20, bottom: 20),
                      //   child: Text(
                      //     'or connect with',
                      //     style: TextStyle(color: Colors.black, fontSize: 18),
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 65),
                      //       child: Container(
                      //         width: 80,
                      //         height: 30,
                      //         child: const Image(
                      //           image:
                      //               AssetImage('assets/images/google.logo.png'),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 80,
                      //       height: 30,
                      //       child: const Image(
                      //         image:
                      //             AssetImage('assets/images/facebook.logo.png'),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 80,
                      //       height: 30,
                      //       child: const Image(
                      //         image: AssetImage('assets/images/apple.logo.png'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
