import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles extends InheritedWidget {
  const AppStyles({
    required super.child,
    super.key,
  });

  static AppStyles of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppStyles>();
    assert(result != null, 'No AppStyles found in context');
    return result!;
  }


  TextStyle get regularHeadline =>
      TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 28.sp,
      );
  TextStyle get semiBoldHeadline =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28.sp,
      );
  TextStyle get regularBody =>
      TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 17.sp,
      );
  TextStyle get semiBoldBody =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
      );
  TextStyle get semiBoldCaption =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );
  TextStyle get regularCaption =>
      TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 13.sp,
      );
  TextStyle get regularSubHeadline =>
      TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 15.sp,
      );
  TextStyle get semiBoldSubHeadline =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
      );

  @override
  bool updateShouldNotify(AppStyles old) => false;
}
