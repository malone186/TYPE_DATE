import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:type_date/main.dart';

void main() {
  testWidgets('App boots to splash/title screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TypeDateApp()));
    await tester.pump();

    expect(find.text('TYPE DATE'), findsOneWidget);
    expect(find.text('시작하기'), findsOneWidget);
  });
}
