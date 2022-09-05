import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/features/registration/domain/registration_bloc.dart';
import 'package:pt_tz/features/registration/presentation/page/login_page.dart';

class RegistrationWrap extends StatefulWidget {
  const RegistrationWrap({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const RegistrationWrap(),
      ).adaptive;

  @override
  State<RegistrationWrap> createState() => _RegistrationWrapState();
}

class _RegistrationWrapState extends State<RegistrationWrap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        if (state is PendingCreateUserRegistrationState) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: 48.r,
                  height: 48.r,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );
        }
        return const LoginPage();
      },
    );
  }
}
