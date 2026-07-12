import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:type_date/screens/blind_date_chat_screen.dart';
import 'package:type_date/screens/character_select_screen.dart';
import 'package:type_date/theme/theme.dart';

void main() {
  testWidgets('1화 완료 시 2화 해금 — 서윤 프로필 거쳐 소개팅 진입', (tester) async {
    SharedPreferences.setMockInitialValues({'td_date01_completed': true});
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildDarkTheme(),
        home: const CharacterSelectScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    // 1화 완료 반영 + 2화(서윤) 해금, 3화(하린)는 아직 잠금
    expect(find.text('1 / 16 완료'), findsOneWidget);
    expect(find.text('서윤 · 28세'), findsOneWidget);
    expect(find.text('하린 · 25세'), findsNothing);

    // 서윤 슬롯 → 프로필
    await tester.tap(find.text('서윤 · 28세'));
    await tester.pumpAndSettle();
    expect(find.text('INTJ'), findsOneWidget);
    expect(find.text('전략기획자 · 서울'), findsOneWidget);

    // 소개팅 시작 → 채팅 화면이 2화 데이터로 열림
    await tester.tap(find.text('소개팅 시작'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(BlindDateChatScreen), findsOneWidget);
    expect(find.text('INTJ · 28'), findsOneWidget);

    // 도입부~턴1 타이머를 순차 소진 — 첫 턴 선택지가 뜰 때까지 (선택지가 뜨면 대기 타이머 없음)
    final choiceFinder = find.textContaining('어색함을 견디면서');
    for (var i = 0; i < 400 && choiceFinder.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }
    expect(choiceFinder, findsOneWidget);
    expect(find.textContaining('이런 자리 익숙한 편이에요'), findsOneWidget);
  });

  testWidgets('1화 미완료 시 2화 슬롯은 잠금', (tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildDarkTheme(),
        home: const CharacterSelectScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('0 / 16 완료'), findsOneWidget);
    expect(find.text('지수 · 26세'), findsOneWidget);
    expect(find.text('서윤 · 28세'), findsNothing);
  });
}
