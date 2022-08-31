import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_tz/common/resources/widgets/adaptive_route.dart';
import 'package:pt_tz/features/registration/presentation/page/login_page.dart';

class RegistrationWrap extends StatelessWidget {
  const RegistrationWrap({super.key});

  static Route route() => AdaptiveRoute<void>(
        builder: (_) => const RegistrationWrap(),
      ).adaptive;

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
