import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/features/app/domain/launcher_bloc.dart';
import 'package:pt_tz/features/app/presentation/pages/app_page.dart';
import 'package:pt_tz/features/auth/domain/auth_bloc.dart';
import 'package:pt_tz/features/auth/presentation/pages/auth_page.dart';
import 'package:pt_tz/features/registration/domain/registration_bloc.dart';
import 'package:pt_tz/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    AppStyles(
      child: MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) => FirebaseAuth.instance,
          ),
          BlocProvider(create: (_) => LauncherBloc()),
          ProxyProvider<FirebaseAuth, AuthBloc>(
            update: (_, auth, bloc) => AuthBloc(auth),
            lazy: true,
          ),
          ProxyProvider<FirebaseAuth, RegistrationBloc>(
            update: (_, auth, bloc) => RegistrationBloc(auth),
            lazy: true,
          ),
        ],
        child: const Application(),
      ),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: Locales.delegate.supportedLocales,
      theme: _theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        Locales.delegate,
      ],
      home: const AppPage(
        child: AuthPage(),
      ),
    );
  }

  ThemeData get _theme {
    return ThemeData(
      fontFamily: 'SanFrancisco',
    );
  }
}
