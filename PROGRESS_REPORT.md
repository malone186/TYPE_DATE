# TYPE DATE — 프로토타입 진행상황 보고서

> 작성일: 2026-06-30
> 대상: PRD v1.2 / UI 디자인 명세서 v1.0 기반 Flutter 데모 프로토타입
> 위치: `c:\TYPE_DATE` (Flutter 프로젝트 루트)

---

## 1. 현재 상태 요약

PRD 1화(ENFP 지수) 기준 **전체 플로우가 동작하는 데모**가 완성된 상태.
Flutter Web으로 빌드되며 `flutter run -d chrome`으로 즉시 실행 가능. 정적 배포용 빌드(`flutter build web`)도 정상 생성 확인.

| 항목 | 상태 |
|---|---|
| `flutter analyze` | 통과 (이슈 0건) |
| `flutter test` | 통과 |
| `flutter build web --release` | 빌드 성공 |
| 1화 콘텐츠(프롤로그~에필로그, 13턴) | 전체 구현 |
| 2~16화 | 미구현 — 캐릭터 선택 화면에 잠금 슬롯으로만 표시 |
| 광고/인앱결제(P1) | 미구현 (PRD상 P1 범위라 데모 제외) |

---

## 2. 구현된 화면 (8개)

1. 스플래시 / 타이틀
2. 프롤로그 (민준 카톡 → 고객센터 → 온보딩 → 배정 카드)
3. 캐릭터 선택 (16슬롯, 1화만 해금)
4. 캐릭터 프로필 (지수)
5. 소개팅 채팅 (13턴, ABCD 선택 + 호감도 이펙트)
6. 결과 보고서 (4축 그래프, 엔딩, 궁합)
7. SNS 공유 카드
8. 에필로그 (민준 카톡 + 2화 예고)

라이트/다크 테마, UI 명세서 v1.0 컬러 토큰, Pretendard 폰트 전부 적용.

---

## 3. 진행 중 겪은 오류 — 원인 / 해결

### 3-1. Riverpod 3.x API 불일치로 인한 컴파일 에러

- **현상**: `StateNotifier`, `StateNotifierProvider`, `StateProvider`가 `flutter_riverpod` 패키지에서 "정의되지 않음(undefined)" 에러 발생.
- **원인**: 프로젝트에 설치된 `flutter_riverpod 3.3.2`는 기존 `StateNotifier` 기반 API를 코어에서 제거하고 `Notifier` / `NotifierProvider`로 대체함. `StateProvider`는 `flutter_riverpod/legacy.dart`로 이동됨. PRD 작성 시점 기준 코드 예시는 구버전 Riverpod 문법이었음.
- **해결**: `game_state.dart`를 `Notifier<T>` / `NotifierProvider.autoDispose<T>` 패턴으로 재작성하고, `import 'package:flutter_riverpod/legacy.dart';`를 추가해 `StateProvider`(테마 모드 전환용)만 레거시로 유지. 이후 `flutter analyze` 이슈 0건 확인.

### 3-2. 한글 텍스트가 빈 네모(tofu)로 깨져 보임

- **현상**: Flutter Web(CanvasKit 렌더러)에서 일부 한글 글자가 순간적으로 네모 박스로 표시됨. 특히 빠르게 연속 입력했을 때 빈도가 높았음.
- **원인**: 처음에는 Pretendard 폰트를 실제로 번들링하지 않고 시스템 기본 폰트에 의존했음. CanvasKit은 번들 폰트에 없는 글리프를 만나면 Google 호스팅 폰트를 런타임에 동적으로 내려받아 채우는데, 이 fetch 지연 때문에 막 렌더링된 글자가 일시적으로 깨져 보이는 현상이 발생.
- **해결**: Pretendard 공식 GitHub 릴리스(`orioncactus/pretendard` v1.3.9)에서 OTF 4종(Regular/Medium/SemiBold/Bold)을 직접 받아 `assets/fonts/`에 번들링하고 `pubspec.yaml`의 `fonts:` 섹션 + `ThemeData(fontFamily: 'Pretendard')`로 정식 등록. 이후 네트워크 의존 없이 즉시 정상 렌더링되는 것을 확인.

### 3-3. (검증 과정에서만 발생) Chrome 창이 다른 창에 가려지면 타이머가 멈춤

- **현상**: 자동화 도구(Chrome DevTools Protocol)로 검증하던 중, 소개팅 채팅 화면에서 선택 후 1.1~1.3초 뒤 자동으로 다음 턴으로 넘어가야 하는 타이머가 응답하지 않고 멈춘 것처럼 보임.
- **원인**: 검증용 Chrome 창이 다른 창(에디터 등)에 가려져 있을 때 Chrome의 "창 가림(occlusion) 감지" 기능이 해당 탭을 백그라운드로 간주해 JS/Dart 타이머를 강제로 쓰로틀링함. **이는 자동화 테스트 환경에서만 발생하는 현상이며 앱 자체의 버그가 아님** — 실제 사용자가 앱을 보고 있는 동안에는 창이 가려질 일이 없으므로 영향 없음. 창을 다시 전면으로 가져오자 즉시 정상 동작 재개.
- **조치**: 별도 코드 수정 없음 (앱 정상). 참고용으로만 기록.

### 3-4. (해결 보류) 폴더 재배치 후 빈 디렉터리 삭제 실패

- **현상**: 사용자 요청으로 `type_date_app/` 하위 파일을 `TYPE_DATE` 루트로 이동한 뒤, 비어 있는 `type_date_app` 폴더를 삭제하려 했으나 "다른 프로세스가 사용 중"이라는 오류로 실패.
- **원인**: VSCode의 Dart Analysis Server(또는 관련 워처)가 기존 경로를 계속 핸들로 잡고 있어서 발생. 파일 이동 자체는 정상 완료되었고, 잠긴 것은 내용물이 없는 빈 폴더 하나뿐.
- **해결 방법(권장)**: 에디터를 한 번 리로드/재시작하면 핸들이 풀려 빈 폴더 삭제 가능. 코드/데이터에는 영향 없음.

### 3-5. UX 구조가 PRD 의도와 다르게 구현됨 (사용자 피드백으로 수정 완료)

- **현상**: 초기 구현에서 ① 민준 카톡/고객센터/에필로그 채팅이 탭해야만 다음 메시지가 나오는 방식이었고, ② 소개팅 채팅 화면이 턴마다 화면이 리셋되며 선택지를 고르는 "퀴즈" 형태로 보였음.
- **원인**: PRD 문서상 "탭하면 다음 메시지 출력"이라는 문구를 글자 그대로 구현했으나, 실제 의도(실제 만남처럼 자연스럽게 흘러가는 느낌)와는 차이가 있었음.
- **해결**: 전면 재작업 완료.
  - 민준 카톡/고객센터/에필로그: 사용자 입력 없이 메시지 길이에 비례한 딜레이(0.7~2.2초)로 자동 진행되도록 변경 (`kakao_chat_view.dart`).
  - 소개팅 채팅: 선택한 답변이 실제 "전송된 내 메시지"로 즉시 말풍선에 쌓이고, 이전 턴들의 대화가 전부 위로 누적되는 실제 메신저형 스레드 구조로 변경 (`blind_date_chat_screen.dart`, `game_state.dart`에 `history` 누적 로직 추가).

---

## 4. 아직 안 한 것 (참고)

- 2~16화 캐릭터/스크립트 (PRD에는 1화만 전체 명세 있음)
- SNS 카드 실제 이미지 저장/공유 기능 (현재는 버튼만 있고 "데모 버전" 안내 스낵바만 뜸)
- 배너 광고, 인앱결제 (PRD P1 범위, 데모 단계 제외)
- 16화 완료 최종 보고서

---

## 5. 실행 방법

```
cd c:\TYPE_DATE
flutter run -d chrome
```

배포용 정적 빌드:
```
flutter build web --release
```
결과물은 `build/web/`에 생성되며, 이 폴더를 Vercel / Netlify / GitHub Pages 등에 그대로 올리면 됩니다.
