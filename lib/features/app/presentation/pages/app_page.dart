import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_tz/features/app/domain/launcher_bloc.dart';
import 'package:pt_tz/features/auth/presentation/pages/auth_page.dart';
import 'package:pt_tz/features/home/presentation/pages/home_page.dart';

class AppPage extends StatefulWidget {
  final Widget child;

  const AppPage({required this.child, super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final FirebaseAuth auth;
  late final LauncherBloc bloc;
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    bloc = context.read<LauncherBloc>();
    auth = context.read<FirebaseAuth>();
    subscription = auth.authStateChanges().listen((User? user) {
      if(user != null){
        bloc.add(LauncherEvent.singIn(user: user));
      }
    });
    bloc.add(LauncherEvent.singIn(user: auth.currentUser));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 667),
      minTextAdapt: true,
    );
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LauncherBloc, LauncherState>(
          builder: (context, state) {
            if (state is PendingAuthenticateLauncherState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SuccessAuthenticateLauncherState) {
              return const HomePage();
            }
            if(state is SuccessLogoutLauncherState){
              return const AuthPage();
            }
            return const AuthPage();
          },
        ),
      ),
    );
  }
}
