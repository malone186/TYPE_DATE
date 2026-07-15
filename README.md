# TYPE DATE — React Native (Expo)

Flutter(Dart) 프로토타입을 **React Native + TypeScript(Expo)** 로 이식한 버전입니다.
기능·대본·이미지·폰트는 원본과 동일하며, 언어/프레임워크만 교체했습니다.

## 기술 스택 매핑 (Flutter → RN)

| Flutter | React Native |
|---|---|
| Dart | TypeScript |
| Widget | React 컴포넌트 |
| Riverpod | Zustand (`src/state/store.ts`) |
| shared_preferences | AsyncStorage |
| MaterialPageRoute / Navigator | React Navigation (native-stack) |
| ThemeData / ThemeExtension | 테마 토큰 + `useColors` 훅 (`src/theme/`) |
| BackdropFilter blur | expo-blur (BlurView) |
| Gradient | expo-linear-gradient / react-native-svg |
| Material Icons | @expo/vector-icons |
| pubspec.yaml | package.json |

## 실행

```bash
npm install
npx expo start          # QR로 Expo Go 실행 (iOS/Android)
npx expo start --web    # 웹
npm run typecheck       # tsc 타입 체크
```

## 웹 정적 빌드 (Vercel/Netlify 배포용)

```bash
npx expo export -p web  # dist/ 생성
```

## 구조

```
src/
  types/        데이터 모델 (models.dart 이식)
  theme/        컬러 토큰 · 텍스트 스타일 · useColors 훅
  state/        Zustand 스토어 (game_state.dart 이식)
  data/         16화 대본 데이터 (episode*.ts) + index
  widgets/      공용 컴포넌트 (common, ChoiceList, KakaoChatView, LikeEffectOverlay)
  screens/      9개 화면
  navigation/   RootNavigator + 라우트 타입
assets/         images · fonts (Pretendard)
```
