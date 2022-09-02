import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/resources/resources.dart';

class AuthBottomSheet extends StatelessWidget {
  const AuthBottomSheet({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final styles = AppStyles.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 4.r,
            width: 53.r,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Image.asset(Images.sadMusk),
          SizedBox(
            height: 16.h,
          ),
          Text(title, style: styles.semiBoldBody)
        ],
      ),
    );
  }
}
