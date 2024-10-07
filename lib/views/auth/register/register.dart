import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/auth/login/login.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/custom_text_button.dart';
import 'package:kidflix_app/widgets/custom_text_field.dart';
import 'package:kidflix_app/widgets/kidflix_app_bar.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController kidNameController = TextEditingController();

  final TextEditingController parentFirstNameController =
      TextEditingController();

  final TextEditingController parentLastNameController =
      TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController birthDateController = TextEditingController();

  DateTime birthDate = DateTime.now();

  String selectedCountry = "Select Country";

  Color genderColor = AppColors.blue;

  int selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.center,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Color.fromARGB(255, 254, 255, 255),
        //       Color.fromARGB(255, 254, 255, 255),
        //       Color.fromARGB(255, 254, 255, 255),
        //       Color.fromARGB(255, 91, 162, 255),
        //       Color.fromARGB(255, 233, 112, 229),
        //     ],
        //   ),
        // ),
        color: Colors.white,
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if (state is KidRegisterSuccessState) {
              cubit.getPackages();
              cubit.getCategories().then((value) {
                cubit
                    .fetchVideos("${cubit.categoryResponse!.data.first.id}")
                    .then((value) {
                  cubit.fetchProfile().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  });
                });
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              // appBar: AppBar(
              //   backgroundColor: Colors.purple,
              // ),
              body: Padding(
                padding: EdgeInsets.all(24.sp),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(20.h),
                        Row(
                          children: [
                            KidflixLogo(
                              width: 60.w,
                            ),
                            Gap(5.w),
                            Text(
                              "Register",
                              style: AppStyles.style36Bold(
                                FontFamily.FIGTREE,
                                color: AppColors.blue,
                              ).copyWith(
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        Gap(20.h),
                        Text("Secutity",
                            style: AppStyles.style14Regular(
                              FontFamily.FIGTREE,
                              color: Colors.grey,
                            ).copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                        Gap(10.h),
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
                          labelText: "Email",
                          hintText: "ex@kidflix.com",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: genderColor,
                          ),
                        ),
                        Gap(15.h),
                        CustomTextField(
                          controller: passwordController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Password is required";
                            } else if (p0.length < 6) {
                              return "password must be at least 6 characters";
                            }
                            return null;
                          },
                          labelText: "Password",
                          hintText: "********",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: genderColor,
                          ),
                          isObsecure: true,
                          canUnObsecure: true,
                        ),
                        Gap(15.h),
                        CustomTextField(
                          controller: confirmPasswordController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Confirm Password is required";
                            } else if (p0 != passwordController.text) {
                              return "passwords do not match";
                            }
                            return null;
                          },
                          labelText: "Confirm Password",
                          hintText: "********",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: genderColor,
                          ),
                          isObsecure: true,
                          canUnObsecure: true,
                        ),
                        Gap(15.h),
                        Text("Personal Information",
                            style: AppStyles.style14Regular(
                              FontFamily.FIGTREE,
                              color: Colors.grey,
                            ).copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                        Gap(10.h),
                        CustomTextField(
                          controller: kidNameController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Kid Name is required";
                            }
                            return null;
                          },
                          labelText: "Kid Name",
                          hintText: "Kid Name",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: genderColor,
                          ),
                        ),
                        Gap(15.h),
                        // dropdown menu for gender
                        DropdownButtonFormField<int>(
                          dropdownColor: Colors.white,
                          value: selectedGender,
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Female"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value == 0) {
                                genderColor = AppColors.blue;
                              } else {
                                genderColor = AppColors.purble;
                              }
                              selectedGender = value!;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey), // Border color
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: genderColor), // Focused border color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12), // Padding inside the field
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Gap(15.h),

                        CustomTextField(
                          controller: parentFirstNameController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Parent First Name is required";
                            }
                            return null;
                          },
                          labelText: "Parent First Name",
                          hintText: "Parent First Name",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: genderColor,
                          ),
                        ),
                        Gap(15.h),
                        CustomTextField(
                          controller: parentLastNameController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Parent Last Name is required";
                            }
                            return null;
                          },
                          labelText: "Parent Last Name",
                          hintText: "Parent Last Name",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: genderColor,
                          ),
                        ),
                        Gap(15.h),
                        Text("More Information",
                            style: AppStyles.style14Regular(
                              FontFamily.FIGTREE,
                              color: Colors.grey,
                            ).copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                        Gap(10.h),

                        CustomButton(
                            backGroundColor: Colors.white,
                            borderColor: genderColor,
                            style: AppStyles.style14Regular(
                              FontFamily.FIGTREE,
                              color: Colors.black,
                            ).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            data: "$selectedCountry",
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode:
                                    true, // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  debugPrint(
                                      'Select country: ${country.displayName}');
                                  setState(() {
                                    selectedCountry = country.displayName;
                                  });
                                },
                              );
                            }),
                        Gap(15.h),
                        // date picker
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != birthDate) {
                              birthDate = picked;
                              birthDateController.text =
                                  "${picked.day}-${picked.month}-${picked.year}";
                            }
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: birthDateController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Birth Date is required";
                                }
                                return null;
                              },
                              labelText: "Birth Date",
                              hintText: "Birth Date",
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                                color: genderColor,
                              ),
                            ),
                          ),
                        ),
                        Gap(15.h),

                        CustomButton(
                          backGroundColor: genderColor,
                          data: "Sign Up",
                          onPressed: state is! KidRegisterLoadingState
                              ? () {
                                  if (formKey.currentState!.validate()) {
                                    // if (selectedCountry == "Select Country") {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(const SnackBar(
                                    //     content: Text("Please select country"),
                                    //   ));
                                    // } else {
                                    debugPrint("register");
                                    cubit.register(
                                        emailController.text,
                                        passwordController.text,
                                        kidNameController.text,
                                        parentFirstNameController.text,
                                        parentLastNameController.text,
                                        selectedCountry,
                                        birthDateController.text,
                                        selectedGender);
                                    // }
                                  }
                                }
                              : null,
                        ),
                        Gap(15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account? ",
                              style: AppStyles.style14Regular(
                                FontFamily.FIGTREE,
                                color: Colors.black,
                              ).copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            CustomTextButton(
                                text: "Login",
                                style: AppStyles.style16Medium(
                                  FontFamily.FIGTREE,
                                  color: genderColor,
                                ).copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                })
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            'or connect with',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: Container(
                                width: 80,
                                height: 30,
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/google.logo.png'),
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 30,
                              child: const Image(
                                image: AssetImage(
                                    'assets/images/facebook.logo.png'),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 30,
                              child: const Image(
                                image:
                                    AssetImage('assets/images/apple.logo.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
