import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:type_date/data/episode1_data.dart';
import 'package:type_date/screens/character_profile_screen.dart';
import 'package:type_date/theme/theme.dart';

void main() {
  testWidgets('profile shows circular face photo', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildDarkTheme(),
        home: const CharacterProfileScreen(character: jisu),
      ),
    ));

    // 실제 에셋 디코딩을 허용해 렌더까지 확인
    await tester.runAsync(() async {
      final ctx = tester.element(find.byType(CharacterProfileScreen));
      await precacheImage(AssetImage(jisu.facePath!), ctx);
    });
    await tester.pumpAndSettle();

    final imageFinder = find.byWidgetPredicate((w) =>
        w is Image &&
        w.image is AssetImage &&
        (w.image as AssetImage).assetName == jisu.facePath);
    expect(imageFinder, findsOneWidget);
    expect(find.byType(ClipOval), findsWidgets);
    // 링(3px 패딩) 안쪽 원형 사진 크기
    expect(tester.getSize(imageFinder), const Size(154, 154));
  });
}
