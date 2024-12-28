import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:kidflix_app/views/auth/login/login.dart';
import 'package:kidflix_app/views/onboarding/onboarding_screen.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/custom_text_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  TextEditingController kidNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController parentFirstNameController = TextEditingController();
  TextEditingController parentLastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    kidNameController.text = cubit.profileResponse.data!.first.kidName;
    emailController.text = cubit.profileResponse.data!.first.email;
    parentFirstNameController.text =
        cubit.profileResponse.data!.first.pFirstName;
    parentLastNameController.text = cubit.profileResponse.data!.first.pLastName;
    countryController.text = cubit.profileResponse.data!.first.country;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is KidEditProfileSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile Updated Successfully"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${getLang(context, "settings")}",
              style: AppStyles.style16Medium(
                FontFamily.FIGTREE,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ProfilePic(
                  image: cubit.profileResponse.data!.first.userProfile == null
                      ? "https://img.freepik.com/premium-vector/cute-boy-smiling-cartoon-kawaii-boy-illustration-boy-avatar-happy-kid_1001605-3453.jpg"
                      : cubit.profileResponse.data!.first.userProfile!.image,
                  imageUploadBtnPress: () {},
                ),
                const Divider(),
                Form(
                  child: Column(
                    children: [
                      UserInfoEditField(
                        text: "${getLang(context, "kidName")}",
                        child: TextFormField(
                          controller: kidNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.purble.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      UserInfoEditField(
                        text: "${getLang(context, "email")}",
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.purble.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      UserInfoEditField(
                        text: "${getLang(context, "parentFirstName")}",
                        child: TextFormField(
                          controller: parentFirstNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.purble.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      UserInfoEditField(
                        text: "${getLang(context, "parentLastName")}",
                        child: TextFormField(
                          controller: parentLastNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.purble.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      UserInfoEditField(
                        text: "${getLang(context, "address")}",
                        child: TextFormField(
                          controller: countryController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.purble.withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      // UserInfoEditField(
                      //   text: "Old Password",
                      //   child: TextFormField(
                      //     obscureText: true,
                      //     initialValue: "demopass",
                      //     decoration: InputDecoration(
                      //       suffixIcon: const Icon(
                      //         Icons.visibility_off,
                      //         size: 20,
                      //       ),
                      //       filled: true,
                      //       fillColor: const AppColors.purble.withOpacity(0.05),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           horizontal: 16.0 * 1.5, vertical: 16.0),
                      //       border: const OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius: BorderRadius.all(Radius.circular(50)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // UserInfoEditField(
                      //   text: "New Password",
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       hintText: "New Password",
                      //       filled: true,
                      //       fillColor: const AppColors.purble.withOpacity(0.05),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           horizontal: 16.0 * 1.5, vertical: 16.0),
                      //       border: const OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius: BorderRadius.all(Radius.circular(50)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    onPressed: () {
                      showAddPasswordDialog(context, () {
                        cubit.editProfile(
                            kidNameController.text,
                            emailController.text,
                            parentFirstNameController.text,
                            parentLastNameController.text,
                            countryController.text,
                            cubit.accessCode,
                            context);
                      });
                    },
                    data: "${getLang(context, "save")}",
                  ),
                ),
                Gap(15.h),
                CustomTextButton(
                    text: "${getLang(context, "signOut")}",
                    style: AppStyles.style16Medium(
                      FontFamily.FIGTREE,
                      color: Colors.red,
                    ).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen(),
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 100.sp,
            height: 100.sp,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100.sp)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.sp),
              child: CachedNetworkImage(
                imageUrl: image ??
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
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
