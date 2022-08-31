import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveRoute<T> {
  final WidgetBuilder builder;
  final RouteSettings? settings;
  final bool maintainState;
  final bool fullscreenDialog;

  AdaptiveRoute({
    required this.builder,
    this.settings,
    this.maintainState = true,
    this.fullscreenDialog = false,
  });

  Route<T> get adaptive => defaultTargetPlatform == TargetPlatform.iOS
      ? CupertinoPageRoute<T>(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  )
      : MaterialPageRoute<T>(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );
}