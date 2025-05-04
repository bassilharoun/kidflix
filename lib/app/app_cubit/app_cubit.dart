import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidflix_app/app/app_cubit/app_states.dart';
import 'package:kidflix_app/app/app_cubit/time_check_cubit.dart';
import 'package:kidflix_app/app/global_functions.dart';
import 'package:kidflix_app/app/helpers/app_locale.dart';
import 'package:kidflix_app/app/helpers/cache_helper.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/domain/models/category_model.dart';
import 'package:kidflix_app/domain/models/package_model.dart';
import 'package:kidflix_app/domain/models/user_model.dart';
import 'package:kidflix_app/domain/models/video_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  // static bool absorbPointerDuringTransition = false;

  bool isStaySignedIn = false;

  void changeStaySignedIn() {
    isStaySignedIn = !isStaySignedIn;
    emit(AppChangeStaySignedIn());
  }

  int selectedPaymentMethod = 0;

  void changePaymentMethod(int index) {
    selectedPaymentMethod = index;
    emit(AppChangePaymentMethod());
  }

  var dio = Dio();

  var headers = {'Accept': 'application/json'};
  Future<void> login(String email, String password, context) async {
    emit(KidLoginLoadingState());
    try {
      var data = FormData.fromMap(
        {
          'email': email,
          'password': password,
        },
      );

      var response = await dio.request(
        'https://kidflix.app/api/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        // add the barear access token to the header
        headers = {
          'Accept': 'application/json',
        'Authorization': 'Bearer ${response.data['access_token']}',
          'Accept-Language': '${getCurrentLang(context)}',
        };
        await cacheUserToken(response.data['access_token']);

        emit(KidLoginSuccessState());
      } else {
        print(response.statusMessage);
        emit(KidLoginErrorState());
      }
    } catch (err) {
      emit(KidLoginErrorState());
      debugPrint(err.toString());
    }
  }

  Future<void> register(
      String email,
      String password,
      String kidName,
      String parentFirstName,
      String parentLastName,
      String country,
      String birthDate,
      int gender,
      context) async {
    emit(KidRegisterLoadingState());
    // try {
    var data = FormData.fromMap(
      {
        'email': email,
        'password': password,
        'kid_name': kidName,
        'p_first_name': parentFirstName,
        'p_last_name': parentLastName,
        'country': country,
        'birthdate': birthDate,
        'gender': gender
      },
    );
    debugPrint("data to register is ${data}");

    var response = await dio.request(
      'https://kidflix.app/api/register',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${response.data['access_token']}',
        'Accept-Language': '${getCurrentLang(context)}',
      };
      await checkPassword(password, context);
      manageProfile(accessCode).then((value) {});
      await cacheUserToken(response.data['access_token']);
    } else {
      print("status message ${response.statusMessage}");
      emit(KidRegisterErrorState());
    }
    // } catch (err) {
    //   emit(KidRegisterErrorState());
    //   debugPrint(err.toString());
    // }
  }

  Future<void> cacheUserToken(String token) async {
    await CacheHelper.saveData(key: 'user_token', value: token);
  }

  Future<void> manageProfile(String passwordConfirm) async {
    emit(KidManageProfileLoadingState());
    try {
      var response = await dio.post('https://kidflix.app/api/manage-profile',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: FormData.fromMap(
              {'song_active': '0', 'password_code_confirm': passwordConfirm}));
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        emit(KidRegisterSuccessState());
      } else {
        print(response.statusMessage);
        emit(KidManageProfileErrorState());
      }
    } catch (err) {
      emit(KidManageProfileErrorState());
      debugPrint("manage profile error:  ${err.toString()}");
    }
  }

  VideoModel videos = emptyVideoModel;

  Future<void> fetchVideos(
    String categoryId,
  ) async {
    emit(KidVideosLoadingState());
    // Define headers and data

    var data = FormData.fromMap({
      'category_id': categoryId,
    });

    // Create Dio instance

    try {
      // Make the request
      var response = await dio.request(
        'https://kidflix.app/api/get-videos',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse response to ApiResponse model
        videos = VideoModel.fromJson(response.data);
        debugPrint("videos is ${json.encode(response.data)}");
        debugPrint("videos is ${videos.videos!.length}");

        emit(KidVideosSuccessState());
      } else {
        emit(KidVideosErrorState());
        // Print the status message if request failed
        debugPrint('Failed: ${response.statusMessage}');
      }
    } catch (e) {
      emit(KidVideosErrorState());
      // Handle any exceptions
      debugPrint('Error: $e');
    }
  }

  void onUserTimeActiveReceived(
      BuildContext context, List<UserTimeActive> userTimeActiveList) {
    // Start checking with the parsed userTimeActiveList
    BlocProvider.of<TimeCheckCubit>(context).startChecking(userTimeActiveList);
  }

  ProfileResponse profileResponse = ProfileResponse(
    status: false,
    data: [],
    message: '',
  );

  Future<void> fetchProfile(context) async {
    try {
      var response = await dio.get(
        'https://kidflix.app/api/get-profile',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("profile response ${json.encode(response.data)}");

      if (response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(response.data);
        if (profileResponse.data!.first.gender == 0) {
          AppColors.purble = Color.fromARGB(255, 24, 142, 205);
        } else {
          AppColors.purble = Color(0xFFDB01D5);
        }
        print('Status: ${profileResponse.status}');
        print('Message: ${profileResponse.message}');
        print('User Data: ${profileResponse.data}');
        onUserTimeActiveReceived(
            context, profileResponse.data!.first.userTimeActive);
        emit(KidProfileSuccessState());
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  PackageResponse? packageResponse;
  Future<void> getPackages() async {
    emit(KidPackagesLoadingState());
    try {
      var response = await dio.request(
        'https://kidflix.app/api/get-packages',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));

        packageResponse = PackageResponse.fromJson(response.data);
        emit(KidPackagesSuccessState());
      } else {
        debugPrint('Error: ${response.statusMessage}');
        emit(KidPackagesErrorState());
      }
    } catch (e) {
      // Handle any errors
      debugPrint('Exception occurred: $e');
      emit(KidPackagesErrorState());
    }
  }

  int selectedPackage = -1;
  changeSelectedPackage(int index) {
    selectedPackage = index;
    emit(KidChangeSelectedPackage());
  }

  subscribe(int packageId, int planId, context, String passwordConfirm,
      String transactionId) async {
    emit(KidSubscribeLoadingState());
    try {
      var data = FormData.fromMap({
        'package_id': '$packageId',
        'plan_id': '$planId',
        'password_code_confirm': passwordConfirm,
        'transaction_id': transactionId
      });

      var response = await dio.request(
        'https://kidflix.app/api/subscripe-package',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        await fetchProfile(context);
        await getCategories();
        await fetchVideos('1');
        emit(KidSubscribeSuccessState());
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      emit(KidSubscribeErrorState());
      debugPrint('Exception: $e');
    }
  }

  CategoryResponse? categoryResponse;

  Future<void> getCategories() async {
    emit(KidCategoriesLoadingState());
    try {
      var response = await dio.request(
        'https://kidflix.app/api/get-categories',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        categoryResponse = CategoryResponse.fromJson(response.data);
        debugPrint(json.encode(response.data));
        emit(KidCategoriesSuccessState());
      } else {
        debugPrint('Error: ${response.statusMessage}');
        emit(KidCategoriesErrorState());
      }
    } catch (e) {
      debugPrint('Exception: $e');
      emit(KidCategoriesErrorState());
    }
  }

  Future<void> editProfile(
      String kidName,
      String email,
      String parentFirstName,
      String parentLastName,
      String country,
      String passwordConfirm,
      context) async {
    emit(KidEditProfileLoadingState());
    try {
      var response = await dio.post(
        'https://kidflix.app/api/edit-user',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: FormData.fromMap({
          'kid_name': kidName,
          'email': email,
          'p_first_name': parentFirstName,
          'p_last_name': parentLastName,
          'country': country,
          'password_code_confirm': passwordConfirm,
        }),
      );

      if (response.statusCode == 200) {
        await fetchProfile(context);
        emit(KidEditProfileSuccessState());
      } else {
        emit(KidEditProfileErrorState());
      }
    } catch (e) {
      emit(KidEditProfileErrorState());
      debugPrint('Exception: $e');
    }
  }

  String accessCode = '';

  Future<void> checkPassword(String password, context) async {
    try {
      var response = await dio.request(
        'https://kidflix.app/api/get-pass-conf-code',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: FormData.fromMap({'password': password}),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        accessCode = response.data['code'];
        emit(KidCheckPasswordSuccessState());
        showStatusSnackBar(context, "Password is correct", true);
      } else {
        print(response.statusMessage);
        showStatusSnackBar(context, "Password is incorrect", false);
      }
    } catch (e) {
      print('Exception: $e');
      showStatusSnackBar(context, "error", false);
    }
  }

  Future<void> addUserTimeActive(
      String start, String end, String passwordCode, context) async {
    try {
      var response = await dio.request(
        'https://kidflix.app/api/manage-time-active',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: FormData.fromMap({
          'start': start,
          'end': end,
          'password_code_confirm': passwordCode,
        }),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        fetchProfile(context);
        showStatusSnackBar(context, "added successfully", true);
      } else {
        print(response.data);
        showStatusSnackBar(context, "error", false);
      }
    } catch (e) {
      print('Exception: $e');
      showStatusSnackBar(context, "error", false);
    }
  }

  Future<void> deleteTimeActive(String id, String passwordCode, context) async {
    try {
      var response = await dio.request(
        'https://kidflix.app/api/del-time-active',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data:
            FormData.fromMap({'id': id, 'password_code_confirm': passwordCode}),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        showStatusSnackBar(context, "deleted successfully", true);

        fetchProfile(context);
      } else {
        print(response.statusMessage);
        showStatusSnackBar(context, "error", false);
      }
    } catch (e) {
      print('Exception: $e');
      showStatusSnackBar(context, "error", false);
    }
  }
}
