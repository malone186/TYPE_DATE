import { TextStyle } from 'react-native';

// UI 디자인 명세서 v1.0 §2 타입 스케일 (Flutter theme.dart TypeDateTextStyles 이식)
// Flutter의 height(줄간격 배수)는 RN lineHeight(px) = fontSize * height 로 환산.

export const TypeDateTextStyles = {
  resultTitle: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-Bold',
    fontSize: 24,
    lineHeight: 24 * 1.3,
    color,
  }),

  screenTitle: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-SemiBold',
    fontSize: 18,
    lineHeight: 18 * 1.4,
    color,
  }),

  chatMessage: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-Regular',
    fontSize: 15,
    lineHeight: 15 * 1.5,
    color,
  }),

  choiceButton: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-Medium',
    fontSize: 14,
    lineHeight: 14 * 1.4,
    color,
  }),

  monologue: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-Regular',
    fontSize: 15,
    fontStyle: 'italic',
    lineHeight: 15 * 1.5,
    color,
  }),

  caption: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-Regular',
    fontSize: 13,
    lineHeight: 13 * 1.4,
    color,
  }),

  choiceLabel: (color: string): TextStyle => ({
    fontFamily: 'Pretendard-SemiBold',
    fontSize: 12,
    lineHeight: 12,
    color,
  }),
};
