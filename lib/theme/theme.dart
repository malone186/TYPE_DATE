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
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.5,
        color: color,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontSize: 12,
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

ThemeData buildLightTheme() {
  const t = TypeDateTokens.light;
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: t.bg,
    brightness: Brightness.light,
    fontFamily: 'Pretendard',
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
