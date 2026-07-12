import 'package:flutter/material.dart';

/// TYPE DATE 컬러 토큰 — UI 디자인 명세서 v1.0 §1 기준
class TypeDateColors {
  TypeDateColors._();

  // Light — 사진의 라벤더/퍼플 새벽빛 톤
  static const lightBg = Color(0xFFEAE3F6);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE3DCF0);
  static const lightTextPrimary = Color(0xFF2B2723);
  static const lightTextSecondary = Color(0xFF9C948A);
  static const lightTextMuted = Color(0xFFC2BAAF);
  static const lightAccentCoral = Color(0xFFFF6F5E);
  static const lightAccentCoralSoft = Color(0xFFF0997B);
  static const lightAccentLavender = Color(0xFFB8A8E8);
  static const lightAccentLavenderText = Color(0xFF26215C);
  static const lightAccentLavenderDeep = Color(0xFF534AB7);
  static const lightBreakBlue = Color(0xFF8A92A6);
  static const lightSuccess = Color(0xFF1D9E75);

  // Dark — 라벤더/퍼플 톤의 밤 버전
  static const darkBg = Color(0xFF201B30);
  static const darkSurface = Color(0xFF2C2742);
  static const darkBorder = Color(0xFF3E3656);
  static const darkTextPrimary = Color(0xFFF5F0EA);
  static const darkTextSecondary = Color(0xFFA39C92);
  static const darkTextMuted = Color(0xFF6E675F);
  static const darkAccentCoral = Color(0xFFFF8669);
  static const darkAccentCoralSoft = Color(0xFFC9694A);
  static const darkAccentCoralSoftText = Color(0xFFFCE5DC);
  static const darkAccentLavender = Color(0xFF453C7A);
  static const darkAccentLavenderText = Color(0xFFD6CFF5);
  static const darkAccentLavenderDeep = Color(0xFF9B8FD9);
  static const darkBreakBlue = Color(0xFF6B7388);
  static const darkSuccess = Color(0xFF5DCAA5);
}

/// 다크모드 대응 토큰 묶음. context 에서 `TypeDateTheme.of(context)` 로 접근.
class TypeDateTokens extends ThemeExtension<TypeDateTokens> {
  final Color bg;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accentCoral;
  final Color accentCoralSoft;
  final Color accentCoralSoftText;
  final Color accentLavender;
  final Color accentLavenderText;
  final Color accentLavenderDeep;
  final Color breakBlue;
  final Color success;

  const TypeDateTokens({
    required this.bg,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accentCoral,
    required this.accentCoralSoft,
    required this.accentCoralSoftText,
    required this.accentLavender,
    required this.accentLavenderText,
    required this.accentLavenderDeep,
    required this.breakBlue,
    required this.success,
  });

  static const light = TypeDateTokens(
    bg: TypeDateColors.lightBg,
    surface: TypeDateColors.lightSurface,
    border: TypeDateColors.lightBorder,
    textPrimary: TypeDateColors.lightTextPrimary,
    textSecondary: TypeDateColors.lightTextSecondary,
    textMuted: TypeDateColors.lightTextMuted,
    accentCoral: TypeDateColors.lightAccentCoral,
    accentCoralSoft: TypeDateColors.lightAccentCoralSoft,
    accentCoralSoftText: TypeDateColors.lightTextPrimary,
    accentLavender: TypeDateColors.lightAccentLavender,
    accentLavenderText: TypeDateColors.lightAccentLavenderText,
    accentLavenderDeep: TypeDateColors.lightAccentLavenderDeep,
    breakBlue: TypeDateColors.lightBreakBlue,
    success: TypeDateColors.lightSuccess,
  );

  static const dark = TypeDateTokens(
    bg: TypeDateColors.darkBg,
    surface: TypeDateColors.darkSurface,
    border: TypeDateColors.darkBorder,
    textPrimary: TypeDateColors.darkTextPrimary,
    textSecondary: TypeDateColors.darkTextSecondary,
    textMuted: TypeDateColors.darkTextMuted,
    accentCoral: TypeDateColors.darkAccentCoral,
    accentCoralSoft: TypeDateColors.darkAccentCoralSoft,
    accentCoralSoftText: TypeDateColors.darkAccentCoralSoftText,
    accentLavender: TypeDateColors.darkAccentLavender,
    accentLavenderText: TypeDateColors.darkAccentLavenderText,
    accentLavenderDeep: TypeDateColors.darkAccentLavenderDeep,
    breakBlue: TypeDateColors.darkBreakBlue,
    success: TypeDateColors.darkSuccess,
  );

  @override
  TypeDateTokens copyWith({
    Color? bg,
    Color? surface,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? accentCoral,
    Color? accentCoralSoft,
    Color? accentCoralSoftText,
    Color? accentLavender,
    Color? accentLavenderText,
    Color? accentLavenderDeep,
    Color? breakBlue,
    Color? success,
  }) {
    return TypeDateTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      accentCoral: accentCoral ?? this.accentCoral,
      accentCoralSoft: accentCoralSoft ?? this.accentCoralSoft,
      accentCoralSoftText: accentCoralSoftText ?? this.accentCoralSoftText,
      accentLavender: accentLavender ?? this.accentLavender,
      accentLavenderText: accentLavenderText ?? this.accentLavenderText,
      accentLavenderDeep: accentLavenderDeep ?? this.accentLavenderDeep,
      breakBlue: breakBlue ?? this.breakBlue,
      success: success ?? this.success,
    );
  }

  @override
  TypeDateTokens lerp(ThemeExtension<TypeDateTokens>? other, double t) {
    if (other is! TypeDateTokens) return this;
    return TypeDateTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      accentCoral: Color.lerp(accentCoral, other.accentCoral, t)!,
      accentCoralSoft: Color.lerp(accentCoralSoft, other.accentCoralSoft, t)!,
      accentCoralSoftText:
          Color.lerp(accentCoralSoftText, other.accentCoralSoftText, t)!,
      accentLavender: Color.lerp(accentLavender, other.accentLavender, t)!,
      accentLavenderText:
          Color.lerp(accentLavenderText, other.accentLavenderText, t)!,
      accentLavenderDeep:
          Color.lerp(accentLavenderDeep, other.accentLavenderDeep, t)!,
      breakBlue: Color.lerp(breakBlue, other.breakBlue, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

extension TypeDateThemeExt on BuildContext {
  TypeDateTokens get colors =>
      Theme.of(this).extension<TypeDateTokens>() ?? TypeDateTokens.light;
}
