import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/utils/app_color.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';

class MainButton extends StatelessWidget {
  final String text;

  const MainButton(this.text, {
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final styles = AppStyles.of(context);
    return SizedBox(
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: kPrimaryColor,
          padding: EdgeInsets.all(16.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: styles.semiBoldBody,
      ),
    )
    ,
    );
  }
}
