import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/resources/resources.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const HomePage(),
      ).adaptive;

  @override
  Widget build(BuildContext context) {
    final locales = Locales.of(context);
    final styles = AppStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 32.r,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(Images.funnyMusk),
          SizedBox(
            height: 24.h,
          ),
          Text(
            locales.welcomeMessage,
            style: styles.semiBoldBody,
          ),
        ],
      ),
    );
  }
}
