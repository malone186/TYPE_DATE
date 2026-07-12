import '../models/models.dart';
import 'episode4_script.dart';

export 'episode4_script.dart';

/// 4화 ESTJ 유진 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode4_script.dart 참고.

const yujin = TDCharacter(
  id: 'date04_yujin',
  name: '유진',
  age: 29,
  job: '마케팅 팀장',
  location: '서울',
  mbti: 'ESTJ',
  intro: '할 말은 하는 편이에요. 대신 뒤끝은 없어요',
  tags: ['#헬스', '#맛집리스트', '#플래너', '#테니스', '#와인'],
  isUnlocked: true,
  imagePath: 'assets/images/yujin.png',
  facePath: 'assets/images/yujin_face.png',
);

/// 4화(유진) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> yujinStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '유진의 직설 화법에도 기죽지 않고 밝은 에너지로 대화를 부드럽게 이어갔어요.',
    badPoint: '유진에게는 리액션보다 명확한 결론이 잘 통해요. 공감에 근거를 한 스푼 더해보세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '에너지는 통하는데 화법의 온도가 달라요. 유진의 팩트 폭격에 가끔 데일 수 있는 조합.',
    endingMessages: {
      Ending.success: '따뜻한 직진이 통했어요. 유진이 계획에 없던 얘기까지 꺼냈다면, 그건 진심이라는 뜻이에요 🌟',
      Ending.friend: '유진도 즐거웠지만 설렘까지는 못 갔어요. 대신 유진의 맛집 리스트 열람권은 얻은 것 같은데요?',
      Ending.fail: '감성 화법이 유진에게는 조금 붕 뜨게 들렸을 수 있어요. 다음엔 결론부터, 마음은 그다음에!',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '유진의 빠른 템포를 그대로 받아치면서 대화를 시원한 핑퐁으로 만들었어요.',
    badPoint: '가끔은 결론을 잠깐 미루고 상대의 감정을 먼저 읽어주면 완벽해져요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '속도, 온도, 화법까지 다 맞아요. 유진이 먼저 다음 약속을 잡고 싶어지는 상대예요.',
    endingMessages: {
      Ending.success: '명확한 사람은 명확한 사람을 알아봐요. 유진의 캘린더에 이미 다음 약속이 들어갔을걸요? ⚡',
      Ending.friend: '대화 합은 완벽했는데 설렘 스위치가 안 눌렸어요. 근데 이런 관계, 의외로 오래갑니다.',
      Ending.fail: '너무 닮아서 부딪혔을 수도 있어요. 직진과 직진이 만나면 가끔 정면충돌이 나거든요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '유진이 처음으로 약한 모습을 보인 순간, 그 마음을 정확하게 알아봐줬어요.',
    badPoint: '유진은 답을 흐리는 걸 제일 답답해해요. 마음을 정했으면 말로 분명하게 표현해보세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '유진의 속도에 숨이 찰 수 있는 조합. 대신 유진의 약한 순간을 알아보는 건 이 유형뿐이에요.',
    endingMessages: {
      Ending.success: '속도가 아니라 깊이로 이긴 소개팅! 유진이 코끝 시큰해진 거, 아무한테나 일어나는 일 아니에요 🌙',
      Ending.friend: '유진에게 편한 사람으로 남았어요. 템포만 조금 맞추면 다음 단계도 충분히 가능해요.',
      Ending.fail: '유진의 돌직구에 마음을 다 못 보여준 것 같아요. 이 유형과는 표현이 반이에요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '말수는 적어도 답이 늘 정확해서, 유진에게 예측 가능한 사람이라는 신뢰를 줬어요.',
    badPoint: '유진은 표현이 빠른 사람이라, 가끔은 속도를 맞춰서 먼저 마음을 보여주면 좋아요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '유진은 말 많은 사람보다 말이 정확한 사람을 좋아해요. 조용한 확신, 꽤 잘 통해요.',
    endingMessages: {
      Ending.success: '군더더기 없는 화법이 유진의 취향을 저격했어요. 유진이 먼저 캘린더를 여는 상대, 흔치 않아요 🔍',
      Ending.friend: '신뢰는 확실히 쌓였어요. 유진에게는 여기서 표현 한 걸음이면 관계가 바뀔 수 있어요.',
      Ending.fail: '신중함이 유진에게는 보류로 읽혔을 수 있어요. 확실한 사람에게는 확실한 답이 필요해요.',
    },
  ),
};

final episode4 = BlindDate(
  id: 'date04',
  character: yujin,
  turns: yujinTurns,
  openingScript: yujinOpeningScript,
  closingScripts: yujinClosingScripts,
  styleInfo: yujinStyleInfoMap,
);
