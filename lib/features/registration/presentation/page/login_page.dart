import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/common/resources/widgets/insert_separator.dart';
import 'package:pt_tz/features/registration/domain/registration_bloc.dart';
import 'package:pt_tz/features/registration/presentation/page/password_page.dart';
import 'package:pt_tz/features/utils/widgets/input_field.dart';
import 'package:pt_tz/features/utils/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const LoginPage(),
      ).adaptive;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final RegistrationBloc _bloc;
  late final TextEditingController emailController;

  @override
  void initState() {
    _bloc = context.read<RegistrationBloc>();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
          if (state is SuccessSetEmailRegistrationState) {
            Navigator.of(context).push(PasswordPage.route());
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
                    locales.enterMail,
                    style: styles.semiBoldHeadline,
                  ),
                  SizedBox(height: 16.h),
                  InputField(
                    emailController,
                    hintText: locales.mail,
                  ),
                  SizedBox(height: 64.h),
                  MainButton(
                    locales.continueReq,
                    onPressed: () {
                      _bloc.add(
                        SetEmailRegistrationEvent(email: emailController.text),
                      );
                    },
                  ),
                ].insertSeparator(
                      SizedBox(height: 8.h),
                    ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
