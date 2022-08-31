import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/utils/app_color.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/features/app/presentation/widgets/input_field.dart';
import 'package:pt_tz/features/utils/widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController _loginController;
  late final TextEditingController _passController;

  @override
  void initState() {
    _loginController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locales = Locales.of(context);
    final styles = AppStyles.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 130.h,
                ),
                Text(locales.authorization, style: styles.semiBoldHeadline),
                SizedBox(
                  height: 16.h,
                ),
                InputField(
                  _loginController,
                  hintText: locales.mail,
                ),
                SizedBox(
                  height: 8.h,
                ),
                InputField(
                  _passController,
                  obscureText: true,
                  hintText: locales.password,
                  suffixWidget: Text(
                    locales.forgotPassword,
                    style:
                        styles.semiBoldCaption.copyWith(color: kPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 200.h,
                ),
                MainButton(
                  locales.signIn,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                Align(
                  child: RichText(
                    text: TextSpan(
                      text: locales.questionReg,
                      style: styles.regularSubHeadline
                          .copyWith(color: kSecondTextColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: locales.registration,
                          style: styles.semiBoldSubHeadline
                              .copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
