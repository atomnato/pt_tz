import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/utils/app_color.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/common/resources/widgets/insert_separator.dart';
import 'package:pt_tz/features/home/presentation/pages/home_page.dart';
import 'package:pt_tz/features/registration/domain/registration_bloc.dart';
import 'package:pt_tz/features/utils/widgets/input_field.dart';
import 'package:pt_tz/features/utils/widgets/main_button.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const PasswordPage(),
      ).adaptive;

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late final RegistrationBloc _bloc;
  late final TextEditingController passController;
  late final TextEditingController confirmPassController;

  @override
  void initState() {
    _bloc = context.read<RegistrationBloc>();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

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
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is SuccessSetPassRegistrationState) {
            _bloc.add(const RegistrationEvent.createUser());
          }
          if (state is SuccessCreateUserRegistrationState) {
            Navigator.of(context).pushReplacement(HomePage.route());
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 56.h),
                  Text(
                    locales.enterPassword,
                    style: styles.semiBoldHeadline,
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        passController,
                        hintText: locales.password,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        locales.helperPassword,
                        style: styles.regularCaption
                            .copyWith(color: kSecondTextColor),
                      )
                    ],
                  ),
                  InputField(
                    confirmPassController,
                    hintText: locales.replyPassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 48.h),
                  MainButton(
                    locales.continueReq,
                    onPressed: () => _bloc.add(
                      SetPassRegistrationEvent(
                        pass: passController.text,
                        confirmPass: confirmPassController.text,
                      ),
                    ),
                  ),
                ]
                    .insertSeparator(
                      SizedBox(height: 8.h),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
