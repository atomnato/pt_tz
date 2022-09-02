import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/features/registration/presentation/page/password_page.dart';
import 'package:pt_tz/features/utils/widgets/input_field.dart';
import 'package:pt_tz/features/utils/widgets/main_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const LoginPage(),
      ).adaptive;

  @override
  Widget build(BuildContext context) {
    final locales = Locales.of(context);
    final styles = AppStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 32.r,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 64.h),
                Text(
                  locales.enterMail,
                  style: styles.semiBoldHeadline,
                ),
                SizedBox(height: 32.h),
                InputField(
                  TextEditingController(),
                  hintText: locales.mail,
                ),
                SizedBox(height: 64.h),
                MainButton(
                  locales.continueReq,
                  onPressed: () =>
                      Navigator.of(context).push(PasswordPage.route()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
