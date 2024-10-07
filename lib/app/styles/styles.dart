import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FontFamily {
  FIGTREE("Figtree"),
  OUTFIT("Outfit");

  const FontFamily(this.familyName);
  final String familyName;
}

class AppStyles {
  static const String figtree = 'Figtree';

  static TextStyle style36Bold(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style24SemiBold(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style20SemiBold(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style18SemiBold(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style16Medium(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style14Regular(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style12Regular(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }

  static TextStyle style10Regular(FontFamily fontFamily, {Color? color}) {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily.familyName,
      color: color ?? Colors.black,
    );
  }
}
