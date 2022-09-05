import 'package:flutter/material.dart';

extension WidgetInsertSeparator on Iterable<Widget> {

  Iterable<Widget> insertSeparator(
      Widget widget, {
        bool includeToStart = false,
        bool includeToEnd = false,
      }) sync* {
    for (var i = 0; i < length; i++) {
      final current = elementAt(i);
      if (i != 0 || includeToStart) {
        yield widget;
      }
      yield current;
    }

    if (includeToEnd && length > 0) {
      yield widget;
    }
  }
}
