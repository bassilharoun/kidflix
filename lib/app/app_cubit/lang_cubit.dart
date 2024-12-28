import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidflix_app/app/app_cubit/app_cubit.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(const Locale('not'));

  void changeLanguage(String languageCode, context) {
    AppCubit.get(context).getCategories();
    AppCubit.get(context).fetchVideos("2");
    emit(Locale(languageCode));
  }
}
