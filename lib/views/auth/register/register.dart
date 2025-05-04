import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
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

class _RegisterState extends State<Register> with TickerProviderStateMixin {
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
            if (state is KidRegisterLoadingState) {
              showLoadingDialog(context, _controller);
            } else if (state is KidRegisterErrorState) {
              hideLoadingDialog(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error"),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is KidRegisterSuccessState) {
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
                        Text("${getLang(context, "security")}",
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
                          labelText: "${getLang(context, "email")}",
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
                            } else if (p0.length < 8) {
                              return "password must be at least 8 characters";
                            }
                            return null;
                          },
                          labelText: "${getLang(context, "password")}",
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
                          labelText: "${getLang(context, "confirmPassword")}",
                          hintText: "********",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: genderColor,
                          ),
                          isObsecure: true,
                          canUnObsecure: true,
                        ),
                        Gap(15.h),
                        Text("${getLang(context, "personalInfo")}",
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
                          labelText: "${getLang(context, "kidName")}",
                          hintText: "${getLang(context, "kidName")}",
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
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("${getLang(context, "male")}"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("${getLang(context, "female")}"),
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
                          labelText: "${getLang(context, "parentFirstName")}",
                          hintText: "${getLang(context, "parentFirstName")}",
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
                          labelText: "${getLang(context, "parentLastName")}",
                          hintText: "${getLang(context, "parentLastName")}",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: genderColor,
                          ),
                        ),
                        Gap(15.h),
                        Text("${getLang(context, "moreInfo")}",
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
                                      '${getLang(context, "selectCountry")}: ${country.displayName}');
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
                              labelText: "${getLang(context, "birthDate")}",
                              hintText: "${getLang(context, "birthDate")}",
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
                          data: "${getLang(context, "signUp")}",
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
                                        selectedGender,
                                        context);
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
                              "${getLang(context, "haveAnAccount")}",
                              style: AppStyles.style14Regular(
                                FontFamily.FIGTREE,
                                color: Colors.black,
                              ).copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            CustomTextButton(
                                text: "${getLang(context, "login")}",
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
