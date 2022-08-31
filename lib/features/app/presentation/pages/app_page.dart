import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPage extends StatelessWidget {
  final Widget child;

  const AppPage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 667),
      minTextAdapt: true,
    );
    return child;
  }
}
