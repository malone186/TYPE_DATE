import 'package:flutter/material.dart';
import 'colors.dart';

/// UI 디자인 명세서 v1.0 §2 타입 스케일
class TypeDateTextStyles {
  TypeDateTextStyles._();

  static TextStyle resultTitle(Color color) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color,
      );

  static TextStyle screenTitle(Color color) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      );

  static TextStyle chatMessage(Color color) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  static TextStyle choiceButton(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: color,
      );

  static TextStyle monologue(Color color) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.5,
        color: color,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );

  static TextStyle choiceLabel(Color color) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1,
        color: color,
      );
}

/// 화면 전환 시 갑자기 확 바뀌는 느낌(Material3 기본 Zoom 전환)을 없애고
/// 모든 플랫폼에서 부드럽게 슬라이드되도록 통일.
const _smoothPageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
    TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
  },
);

ThemeData buildLightTheme() {
  const t = TypeDateTokens.light;
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: t.bg,
    brightness: Brightness.light,
    fontFamily: 'Pretendard',
    pageTransitionsTheme: _smoothPageTransitions,
    colorScheme: ColorScheme.light(
      primary: t.accentCoral,
      secondary: t.accentLavender,
      surface: t.surface,
    ),
    extensions: const [TypeDateTokens.light],
    textTheme: Typography.material2021().black.apply(
          bodyColor: t.textPrimary,
          displayColor: t.textPrimary,
        ),
  );
}

ThemeData buildDarkTheme() {
  const t = TypeDateTokens.dark;
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: t.bg,
    brightness: Brightness.dark,
    fontFamily: 'Pretendard',
    pageTransitionsTheme: _smoothPageTransitions,
    colorScheme: ColorScheme.dark(
      primary: t.accentCoral,
      secondary: t.accentLavender,
      surface: t.surface,
    ),
    extensions: const [TypeDateTokens.dark],
    textTheme: Typography.material2021().white.apply(
          bodyColor: t.textPrimary,
          displayColor: t.textPrimary,
        ),
  );
}
