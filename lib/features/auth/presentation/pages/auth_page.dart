import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/utils/app_color.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/common/resources/widgets/insert_separator.dart';
import 'package:pt_tz/features/auth/domain/auth_bloc.dart';
import 'package:pt_tz/features/auth/presentation/widgets/auth_bottom_sheet.dart';
import 'package:pt_tz/features/registration/presentation/page/registration_wrap.dart';
import 'package:pt_tz/features/utils/widgets/input_field.dart';
import 'package:pt_tz/features/utils/widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController loginController;
  late final TextEditingController passController;
  late final AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passController = TextEditingController();
    bloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    loginController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locales = Locales.of(context);
    final styles = AppStyles.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is FailureLoginWithEmailAuthState) {
                  _showBottomModel(state.failure.getMessage);
                }
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 100.h),
                  Text(locales.authorization, style: styles.semiBoldHeadline),
                  SizedBox(
                    height: 50.h,
                  ),
                  InputField(
                    loginController,
                    hintText: locales.mail,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InputField(
                        passController,
                        obscureText: true,
                        hintText: locales.password,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        locales.forgotPassword,
                        style: styles.semiBoldCaption
                            .copyWith(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),
                  MainButton(
                    locales.signIn,
                    onPressed: () => bloc.add(
                      LoginWithEmailAuthEvent(
                        email: loginController.text,
                        pass: passController.text,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locales.questionReg,
                        style: styles.regularSubHeadline
                            .copyWith(color: kSecondTextColor),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .push(RegistrationWrap.route()),
                        child: Text(
                          locales.registration,
                          style: styles.semiBoldSubHeadline
                              .copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  )
                ]
                    .insertSeparator(
                      SizedBox(
                        height: 8.h,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomModel(String message) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      enableDrag: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: .8,
        child: AuthBottomSheet(title: message),
      ),
    );
  }
}
