import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:info_minecraft/main.dart';

void main() {
  testWidgets('AppBar title muncul', (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(const MyApp());

    // Cek apakah AppBar title muncul
    expect(find.text('Minecraft Version Checker'), findsOneWidget);
  });

  testWidgets('Loading indicator muncul sebelum data dimuat',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Karena data belum di-load, harus muncul CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
