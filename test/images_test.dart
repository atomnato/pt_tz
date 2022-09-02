import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pt_tz/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.funnyMusk).existsSync(), true);
    expect(File(Images.sadMusk).existsSync(), true);
  });
}
