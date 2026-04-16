import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cost_model/app.dart';

void main() {
  testWidgets('app loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CostModelApp());

    expect(find.text('Cost Model'), findsWidgets);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
