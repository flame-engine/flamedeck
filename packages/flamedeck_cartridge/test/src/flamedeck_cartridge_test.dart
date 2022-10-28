import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlamedeckCartridge', () {
    test('can be instantiated', () {
      expect(
        FlamedeckCartridge(
          cartridgeBuilder: (_) => SizedBox(),
          title: '',
          description: '',
          author: '',
          authorLink: '',
          gameCover: '',
        ),
        isNotNull,
      );
    });
  });
}
