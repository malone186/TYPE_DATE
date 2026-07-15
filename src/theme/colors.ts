// TYPE DATE 컬러 토큰 — UI 디자인 명세서 v1.0 §1 기준 (Flutter colors.dart 이식)

export const TypeDateColors = {
  // Light — 라벤더/퍼플 새벽빛 톤
  lightBg: '#EAE3F6',
  lightSurface: '#FFFFFF',
  lightBorder: '#E3DCF0',
  lightTextPrimary: '#2B2723',
  lightTextSecondary: '#9C948A',
  lightTextMuted: '#C2BAAF',
  lightAccentCoral: '#FF6F5E',
  lightAccentCoralSoft: '#F0997B',
  lightAccentLavender: '#B8A8E8',
  lightAccentLavenderText: '#26215C',
  lightAccentLavenderDeep: '#534AB7',
  lightBreakBlue: '#8A92A6',
  lightSuccess: '#1D9E75',

  // Dark — 라벤더/퍼플 톤의 밤 버전
  darkBg: '#201B30',
  darkSurface: '#2C2742',
  darkBorder: '#3E3656',
  darkTextPrimary: '#F5F0EA',
  darkTextSecondary: '#A39C92',
  darkTextMuted: '#6E675F',
  darkAccentCoral: '#FF8669',
  darkAccentCoralSoft: '#C9694A',
  darkAccentCoralSoftText: '#FCE5DC',
  darkAccentLavender: '#453C7A',
  darkAccentLavenderText: '#D6CFF5',
  darkAccentLavenderDeep: '#9B8FD9',
  darkBreakBlue: '#6B7388',
  darkSuccess: '#5DCAA5',
} as const;

export interface TypeDateTokens {
  bg: string;
  surface: string;
  border: string;
  textPrimary: string;
  textSecondary: string;
  textMuted: string;
  accentCoral: string;
  accentCoralSoft: string;
  accentCoralSoftText: string;
  accentLavender: string;
  accentLavenderText: string;
  accentLavenderDeep: string;
  breakBlue: string;
  success: string;
}

export const lightTokens: TypeDateTokens = {
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
};

export const darkTokens: TypeDateTokens = {
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
};

// Flutter의 Color.withValues(alpha:) 대응 — hex + 0~1 알파를 rgba 문자열로.
export function withAlpha(hex: string, alpha: number): string {
  const h = hex.replace('#', '');
  const r = parseInt(h.substring(0, 2), 16);
  const g = parseInt(h.substring(2, 4), 16);
  const b = parseInt(h.substring(4, 6), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}
