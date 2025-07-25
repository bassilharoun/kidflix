import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class  AppLocale {

  Locale locale ;

  AppLocale(this.locale) ;

  Map<String , String>? loadedLocalizedValues ;

  static AppLocale of (BuildContext context) {
    return Localizations.of(context, AppLocale) ;
  }

  Future loadLang() async {
    String  _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json') ;
    Map<String ,dynamic> _loadedValues = jsonDecode(_langFile);
    loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString())) ;
  }

  String? getTranslated (String key) {
    return loadedLocalizedValues![key] ;
  }

  static const LocalizationsDelegate<AppLocale> delegate  = _AppLocalDelegate() ;

}


class  _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate() ;
  @override
  bool isSupported(Locale locale) {
    return ["ar" , "en"].contains(locale.languageCode) ;
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale) ;
    await appLocale.loadLang();
    return appLocale ;
  }

  @override
  bool shouldReload(_AppLocalDelegate  old) => false  ;

}


getLang(BuildContext context  , String key) {
  return AppLocale.of(context).getTranslated(key) ;
}

String getCurrentLang(BuildContext context) {
  return AppLocale.of(context).locale.languageCode.toLowerCase();
}

