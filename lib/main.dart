import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pt_tz/common/resources/l10n/generated/l10n.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';
import 'package:pt_tz/features/app/presentation/pages/app_page.dart';
import 'package:pt_tz/features/auth/presentation/page/auth_page.dart';

void main() {
  runApp(const AppStyles(child: Application()));
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
