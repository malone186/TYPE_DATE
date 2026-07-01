# TYPE DATE — UI 디자인 명세서

> 작성일: 2026.06
> 버전: v1.0
> 대상: Flutter 개발 (Claude Code 참고용)
> 연관 문서: TYPE DATE PRD v1.2

---

## 0. 디자인 컨셉

**"따뜻한 채팅, 차가운 분석"**

겉으로는 카카오톡 같은 따뜻한 소개팅 채팅. 그 이면에는 13턴 동안 조용히 쌓이는 성격 데이터.
이 이중 구조를 컬러로 분리한다.

| 레이어 | 색 | 쓰임 |
|---|---|---|
| 로맨스 레이어 | 코랄 (Coral) | 호감도, 캐릭터 프사, 핵심 CTA |
| 분석 레이어 | 라벤더 (Lavender) | 선택지 레이블(A/B/C/D), 4축 그래프, 진행률 |

채팅 화면은 실제 메시지 앱처럼 자연스러워야 하고, 결과 화면에서만 "사실 이건 분석이었다"는 게 드러나야 한다.

---

## 1. 컬러 시스템

라이트모드 기본, 다크모드 지원. Flutter `ThemeData` 의 `ColorScheme` 대신 커스텀 토큰을 별도 정의해서 쓰는 걸 권장 (앱 톤이 머티리얼 디폴트와 다름).

### 1-1. 라이트모드

| 토큰 | HEX | 용도 |
|---|---|---|
| `bg` | `#FFFBF6` | 전체 배경 (따뜻한 크림) |
| `surface` | `#FFFFFF` | 말풍선, 카드, 버튼 배경 |
| `border` | `#ECE5DC` | 구분선, 카드 테두리 |
| `textPrimary` | `#2B2723` | 본문 텍스트 |
| `textSecondary` | `#9C948A` | 보조 텍스트, 타임스탬프 |
| `textMuted` | `#C2BAAF` | placeholder, 비활성 텍스트 |
| `accentCoral` | `#FF6F5E` | 주요 CTA, 호감(❤️) 컬러 |
| `accentCoralSoft` | `#F0997B` | 캐릭터 아바타, 보조 강조 |
| `accentLavender` | `#B8A8E8` | 선택지 칩(A/B/C/D) 배경 |
| `accentLavenderText` | `#26215C` | 라벤더 배경 위 텍스트 |
| `accentLavenderDeep` | `#534AB7` | 4축 그래프 강조, 토글 ON |
| `breakBlue` | `#8A92A6` | 실망(💔) 컬러 |
| `success` | `#1D9E75` | (선택) 완료 표시 등 |

### 1-2. 다크모드

| 토큰 | HEX | 용도 |
|---|---|---|
| `bg` | `#1F1C1A` | 전체 배경 (따뜻한 다크, 순검정 아님) |
| `surface` | `#2B2725` | 말풍선, 카드 배경 |
| `border` | `#3D3733` | 구분선, 카드 테두리 |
| `textPrimary` | `#F5F0EA` | 본문 텍스트 |
| `textSecondary` | `#A39C92` | 보조 텍스트 |
| `textMuted` | `#6E675F` | placeholder, 비활성 텍스트 |
| `accentCoral` | `#FF8669` | 주요 CTA, 호감(❤️) 컬러 (다크 배경 대비용으로 약간 밝게) |
| `accentCoralSoft` | `#C9694A` | 캐릭터 아바타 배경 |
| `accentCoralSoftText` | `#FCE5DC` | 아바타 위 텍스트 |
| `accentLavender` | `#453C7A` | 선택지 칩 배경 (반전: 진한 배경) |
| `accentLavenderText` | `#D6CFF5` | 라벤더 칩 위 텍스트 (밝게 반전) |
| `accentLavenderDeep` | `#9B8FD9` | 4축 그래프 강조, 토글 ON |
| `breakBlue` | `#6B7388` | 실망(💔) 컬러 |
| `success` | `#5DCAA5` | (선택) 완료 표시 등 |

### 1-3. 다크모드 전환 규칙

- 단순 색 반전이 아니라 **채도/명도 재조정**. 라벤더 칩은 라이트에서 "연한 배경 + 진한 글자" → 다크에서 "진한 배경 + 밝은 글자"로 반전
- 코랄은 다크 배경에서 가독성 위해 명도를 살짝 올림 (`#FF6F5E` → `#FF8669`)
- 배경은 순검정(`#000000`) 금지. 항상 따뜻한 톤 유지 (앱 정체성 유지)
- Flutter 구현: `ThemeMode.system` 기본값으로 OS 설정 따라가되, 앱 내 설정에서 수동 전환 가능하게 (라이트/다크/시스템 3단 선택)

---

## 2. 타이포그래피

| 항목 | 내용 |
|---|---|
| 폰트 | Pretendard (한글 가독성 우수, 무료, Variable Font) |
| 폰트 적용 | `assets/fonts/Pretendard-*.otf` 로 번들링 (Google Fonts에 없음, 직접 추가 필요) |

### 2-1. 타입 스케일

| 용도 | 크기 | 굵기 | 줄간격 |
|---|---|---|---|
| 결과 화면 메인 타이틀 ("진짜 인연 유형") | 24sp | Bold (700) | 1.3 |
| 화면 타이틀 (캐릭터 이름 등) | 18sp | SemiBold (600) | 1.4 |
| 채팅 메시지 (상대) | 15sp | Regular (400) | 1.5 |
| 선택지 버튼 텍스트 | 14sp | Medium (500) | 1.4 |
| 주인공 독백 | 13sp | Regular (400), Italic | 1.5 |
| 보조 텍스트 (타임스탬프, 캡션) | 12sp | Regular (400) | 1.4 |
| 버튼 레이블 (A/B/C/D) | 12sp | SemiBold (600) | 1 |

### 2-2. 원칙

- 본문은 무조건 Pretendard Regular/Medium. 헤비웨이트(Bold 이상)는 타이틀에만 제한적으로
- 독백은 이탤릭 + 회색으로 "이건 속마음"이라는 걸 시각적으로 분리
- 결과 화면의 "진짜 인연 유형" 타이틀만 24sp Bold로 — 앱 전체에서 가장 임팩트 있는 순간이므로 여기서만 크기 차이를 크게 줌

---

## 3. 레이아웃 & 스페이싱

### 3-1. 스페이싱 스케일

```
4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 (단위: dp)
```

화면 좌우 패딩은 16dp 고정. 컴포넌트 간 기본 간격은 12~16dp.

### 3-2. 코너 반경

| 요소 | radius |
|---|---|
| 채팅 말풍선 (상대) | `4 16 16 16` (좌상단만 작게 — 말풍선 꼬리 느낌) |
| 채팅 말풍선 (나, 있을 경우) | `16 4 16 16` |
| 선택지 버튼 | 14dp |
| 카드 (캐릭터 프로필, 결과 카드) | 16~20dp |
| 작은 칩/배지 (A/B/C/D 레이블, 태그) | 50% (원형) 또는 999 (필) |
| 프사 (아바타) | 50% (원형) |

---

## 4. 핵심 컴포넌트 명세

### 4-1. 채팅 메시지 버블 (상대방)

```
[아바타 24dp] [말풍선]
              상대 메시지 텍스트
```

- 좌측 정렬, 아바타와 8dp 간격
- 배경 `surface`, 테두리 `border` 0.5dp
- 패딩 10dp 16dp(좌우 14dp)
- 최대 너비: 화면의 78%
- 메시지 등장 애니메이션: 아래에서 위로 8dp 슬라이드 + 페이드인, 0.25초

### 4-2. 주인공 독백

- 말풍선 없음, 가운데 정렬
- `textSecondary` 컬러, 이탤릭, 13sp
- 좌우 패딩 24dp (메시지보다 안쪽으로 들어옴 — 속마음이라 더 작고 조심스럽게)

### 4-3. 선택지 버튼 (A/B/C/D)

```
[레이블 칩] 선택지 텍스트
```

- 세로로 4개 스택, 각 버튼 간격 8dp
- 레이블 칩: 20dp 원형, `accentLavender` 배경 + `accentLavenderText` 텍스트
- 버튼 배경 `surface`, 테두리 `border`
- 터치 시: `scale(0.97)` + 배경 살짝 어둡게, 0.1초
- 선택 후: 선택한 버튼만 남기고 나머지 3개는 페이드아웃 → 호감도 이펙트 발동

### 4-4. 호감도 이펙트 (❤️ / 💔)

- 화면 중앙 상단에서 발생
- ❤️: `accentCoral` 하트 아이콘, 위로 떠오르며(20dp) 페이드아웃, 0.5초, 살짝 커졌다가(scale 1.2) 작아짐
- 💔: `breakBlue` 깨진 하트 아이콘, 작게 흔들리고(shake) 페이드아웃, 0.5초
- 이 단계에서는 숫자/점수 절대 노출 금지 — 감정적 반응만

### 4-5. 진행 바 (13턴 중 현재 위치)

- 채팅 화면 상단 헤더에 얇은 바 (4dp 높이)
- `accentLavenderDeep` 채움, `border` 트랙
- 턴 전환마다 부드럽게 채워짐 (애니메이션 0.3초)
- *(턴1 PRD 작성 당시 우상단 숫자 표시 검토했으나 제외 확정 — 진행 바만 사용)*

### 4-6. 캐릭터 카드 (선택 화면 슬롯)

```
┌─────────────┐
│   [프사]      │
│   ENFP       │
│   지수 · 26세  │
└─────────────┘
```

- 해금 상태: 풀 컬러, 터치 가능
- 잠금 상태: 그레이스케일 처리 + 자물쇠 아이콘 오버레이 + 60% 불투명도
- 카드 radius 16dp, 그림자 없음 (플랫 디자인 유지, `border`로만 구분)

### 4-7. 결과 카드 (4축 그래프)

- E/I, N/S, T/F, J/P 4개 가로 막대
- 막대 배경 `border`, 채움 `accentLavenderDeep`
- 각 축 양 끝에 알파벳 레이블 (예: "E ─────●──── I")
- 우세한 쪽으로 채움이 치우치는 형태

---

## 5. 화면별 명세

### 5-1. 스플래시 / 타이틀

```
┌──────────────────┐
│                  │
│    [로고]         │
│   TYPE DATE      │
│                  │
│                  │
│   [시작하기]       │
│   [이어하기]       │
└──────────────────┘
```
- 배경 `bg`, 로고 중앙, 코랄 포인트
- 버튼: 시작하기(`accentCoral` 채움), 이어하기(아웃라인)

### 5-2. 프롤로그 (카카오톡 UI 모방)

```
┌──────────────────┐
│ ← 최민준          │ ← 상단바, surface 배경
├──────────────────┤
│         [내 메시지]│ ← 우측, 노란빛 아님(카톡 색 회피),
│                  │   accentCoralSoft 톤으로 차별화
│ [상대 메시지]       │ ← 좌측, surface
├──────────────────┤
│  (탭하여 계속)      │
└──────────────────┘
```
- 실제 카카오톡과 톤만 다르게 — 노란 말풍선 대신 앱 컬러 시스템 사용 (저작권/혼동 회피)
- 탭으로 다음 메시지, 스킵 불가

### 5-3. 캐릭터 선택 화면

- 2열 그리드, 16개 슬롯
- 상단 진행률: "1 / 16 완료" 텍스트 (작게, `textSecondary`)

### 5-4. 캐릭터 프로필

```
┌──────────────────┐
│    [큰 프사]        │
│    지수 · 26세      │
│    ENFP           │
│    콘텐츠 기획자       │
│                   │
│   #필름카메라 #즉흥여행 │ ← 칩, lavender soft
│                   │
│   [소개팅 시작]      │ ← coral 버튼
└──────────────────┘
```

### 5-5. 소개팅 채팅 화면 (핵심 화면)

```
┌──────────────────┐
│ [아바타] 지수       │ ← 헤더, 진행바 포함
│ ▓▓▓▓░░░░░░░░░░░  │
├──────────────────┤
│ [아바타] 상대 메시지  │
│                   │
│   주인공 독백 (회색)  │
│                   │
│ ⓐ 선택지 텍스트      │
│ ⓑ 선택지 텍스트      │
│ ⓒ 선택지 텍스트      │
│ ⓓ 선택지 텍스트      │
└──────────────────┘
```
- 선택 후: 선택지 사라짐 → 호감도 이펙트 → 상대 반응 메시지 → 다음 턴 자동 진행 (1초 딜레이)
- 타이핑 인디케이터: 상대 메시지 나오기 전 점 3개 바운스 애니메이션 (0.3~0.6초)

### 5-6. 결과 보고서 화면

```
┌──────────────────┐
│   💘 성공          │ ← 엔딩 타입, 큰 이모지
│                   │
│  소개팅계 공감왕 🌟   │ ← 24sp Bold, 시그니처 타이틀
│                   │
│  E ──●────── I    │
│  N ────●──── S    │  ← 4축 그래프
│  T ──●────── F    │
│  J ──────●── P    │
│                   │
│  잘한 점: ...       │
│  아쉬운 점: ...      │
│  궁합: ★★★★☆      │
│                   │
│  [카드 공유] [다음]   │
└──────────────────┘
```

### 5-7. SNS 카드 (공유용 이미지)

- 정사각형 또는 9:16 비율 (인스타 스토리 대응)
- 배경 `bg`, 중앙 정렬
- TYPE DATE 로고 작게 상단 고정
- 유형명 + 이모지 + 한 줄 요약 + 진행률(N/16)

### 5-8. 에필로그 (민준 카톡 + 다음화 예고)

- 프롤로그와 동일한 카톡 UI 컴포넌트 재사용
- 다음화 예고 카드: 잠금 아이콘 + 카운트다운 텍스트

---

## 6. 모션 & 인터랙션 가이드

| 인터랙션 | 지속시간 | easing |
|---|---|---|
| 메시지 등장 | 0.25s | ease-out |
| 버튼 터치 피드백 | 0.1s | ease-out |
| 호감도 이펙트 | 0.5s | ease-in-out |
| 진행 바 채움 | 0.3s | ease-out |
| 화면 전환 | 0.3s | ease-in-out (슬라이드) |
| 타이핑 인디케이터 | 반복 | 점 3개 순차 바운스 |
| 다크/라이트 전환 | 0.2s | 모든 color 속성 transition |

원칙: 과한 모션 지양. 채팅 앱은 빠르고 가벼워야 함. 유일하게 힘을 주는 곳은 **결과 화면 진입 시 4축 그래프가 0에서 차오르는 애니메이션** (0.8초) — 앱에서 가장 "짠" 하는 순간이므로 여기만 의도적으로 느리게.

---

## 7. Flutter 구현 참고

### 7-1. 컬러 토큰 (Dart)

```dart
class TypeDateColors {
  // Light
  static const lightBg = Color(0xFFFFFBF6);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFECE5DC);
  static const lightTextPrimary = Color(0xFF2B2723);
  static const lightTextSecondary = Color(0xFF9C948A);
  static const lightTextMuted = Color(0xFFC2BAAF);
  static const lightAccentCoral = Color(0xFFFF6F5E);
  static const lightAccentCoralSoft = Color(0xFFF0997B);
  static const lightAccentLavender = Color(0xFFB8A8E8);
  static const lightAccentLavenderText = Color(0xFF26215C);
  static const lightAccentLavenderDeep = Color(0xFF534AB7);
  static const lightBreakBlue = Color(0xFF8A92A6);

  // Dark
  static const darkBg = Color(0xFF1F1C1A);
  static const darkSurface = Color(0xFF2B2725);
  static const darkBorder = Color(0xFF3D3733);
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
}
```

### 7-2. 다크모드 토글 구현 방식

- `ThemeMode` 상태를 Riverpod `StateProvider<ThemeMode>` 로 관리
- 기본값 `ThemeMode.system`
- 설정 화면(또는 캐릭터 선택 화면 상단)에 라이트/다크/시스템 3단 토글 배치
- `SharedPreferences` 에 선택값 저장 → 앱 재시작 시 유지

```dart
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

ThemeData buildLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: TypeDateColors.lightBg,
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.light(
      primary: TypeDateColors.lightAccentCoral,
      secondary: TypeDateColors.lightAccentLavender,
      surface: TypeDateColors.lightSurface,
    ),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: TypeDateColors.darkBg,
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.dark(
      primary: TypeDateColors.darkAccentCoral,
      secondary: TypeDateColors.darkAccentLavender,
      surface: TypeDateColors.darkSurface,
    ),
  );
}
```

### 7-3. 폰트 등록 (pubspec.yaml)

```yaml
fonts:
  - family: Pretendard
    fonts:
      - asset: assets/fonts/Pretendard-Regular.otf
        weight: 400
      - asset: assets/fonts/Pretendard-Medium.otf
        weight: 500
      - asset: assets/fonts/Pretendard-SemiBold.otf
        weight: 600
      - asset: assets/fonts/Pretendard-Bold.otf
        weight: 700
```

---

## 8. 접근성 / 일관성 체크리스트

- 모든 텍스트-배경 조합 명도 대비 WCAG AA 이상 (특히 다크모드 `textSecondary` 위에 `accentLavender` 칩 텍스트 등)
- 터치 영역 최소 44x44dp (선택지 버튼, 아이콘 버튼)
- 다크모드 전환 시 이미지 에셋(캐릭터 프사)은 그대로, 배경/카드/텍스트만 전환
- 색맹 고려: 호감도(❤️/💔)는 색만이 아니라 아이콘 형태로도 구분 (이미 설계에 포함됨)

---

## 변경 이력

| 버전 | 날짜 | 변경 내용 |
|---|---|---|
| v1.0 | 2026.06 | 최초 작성. 라이트/다크 컬러 토큰, 타이포그래피, 컴포넌트 명세, 화면별 와이어프레임, Flutter 구현 가이드 포함 |
