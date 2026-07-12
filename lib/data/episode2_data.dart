import '../models/models.dart';
import 'episode2_script.dart';

export 'episode2_script.dart';

/// 2화 INTJ 서윤 — 캐릭터·데이터 조립.
/// 대사·연출 대본은 episode2_script.dart 참고.

const seoyun = TDCharacter(
  id: 'date02_seoyun',
  name: '서윤',
  age: 28,
  job: '전략기획자',
  location: '서울',
  mbti: 'INTJ',
  intro: '차갑다는 말 많이 들어요. 근데 사실 그게 싫어요',
  tags: ['#독서', '#전시회', '#체스', '#블랙커피', '#계획여행'],
  isUnlocked: true,
  imagePath: 'assets/images/seoyun.png',
  facePath: 'assets/images/seoyun_face.png',
);

/// 유형별 보고서 텍스트 — 서윤(INTJ) 기준
final Map<String, StyleInfo> seoyunStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '서윤의 딱딱한 첫인상에 주눅 들지 않고 따뜻하게 다가갔어요.',
    badPoint: '서윤 같은 사람에게는 텐션보다 정확한 한마디가 더 깊게 닿아요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '따뜻함은 전해지지만, 서윤에게는 조금 소란스럽게 느껴질 수 있어요.',
    endingMessages: {
      Ending.success: '높은 텐션 너머의 진심이 서윤에게 닿았어요. 흔치 않은 조합인 만큼 특별한 케미가 기대돼요 🌟',
      Ending.friend: '서윤이 마음의 문을 반쯤 열었어요. 페이스를 조금만 늦추면 나머지 반도 열릴지 몰라요.',
      Ending.fail: '에너지 차이가 컸던 것 같아요. 서윤 같은 유형에게는 침묵도 대화라는 걸 기억해요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '에너지 넘치는 현실주의자',
    summary: '활발하지만 논리적이에요. 대화를 주도하는 타입.',
    goodPoint: '서윤의 논리적인 화법에 밀리지 않고 자기 생각을 분명하게 전달했어요.',
    badPoint: '서윤이 고민을 꺼낼 때는 해결책보다 마음을 먼저 읽어주면 좋아요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '논리는 잘 통하지만 에너지 템포에서 온도 차이가 있어요.',
    endingMessages: {
      Ending.success: '주도적인 대화가 서윤의 흥미를 끌었어요. 논리와 논리가 만나면 꽤 재밌는 연애가 되죠 ⚡',
      Ending.friend: '대화는 잘 통했지만 서윤은 아직 관찰 중이에요. 조급해하지 않는 게 포인트예요.',
      Ending.fail: '서윤의 속도를 앞질러 가버린 것 같아요. INTJ는 스스로 결론 내릴 시간이 필요해요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '서윤의 말 뒤에 숨은 마음을 조용히 읽어냈어요. 차갑다는 오해 속 진심을 알아봤죠.',
    badPoint: '서윤이 다음을 물을 때는 조금 더 분명하게 답해줘도 괜찮아요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '조용한 온기가 서윤의 벽을 천천히 녹이는 조합이에요.',
    endingMessages: {
      Ending.success: '서두르지 않는 깊은 공감이 서윤의 마음을 열었어요. 서윤의 다음 연락, 생각보다 빠를 거예요 🌙',
      Ending.friend: '서윤에게 편안한 사람으로 남았어요. INTJ의 신뢰는 느리게 쌓이지만 한번 쌓이면 단단해요.',
      Ending.fail: '결이 나쁘지 않았는데 확신을 주지 못했어요. 다음엔 마음을 조금 더 보여줘요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '차분한 분석가',
    summary: '신중하고 이성적이에요. 조용히 관찰하는 타입.',
    goodPoint: '복기, 밀도, 지도 같은 서윤의 언어로 대화했어요. 사고의 결이 잘 맞았죠.',
    badPoint: '가끔은 분석을 멈추고 느낀 그대로를 말해주면 서윤이 더 빨리 다가올 거예요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '사고의 결이 같아요. 말하지 않아도 통하는 최고의 궁합.',
    endingMessages: {
      Ending.success: '서윤이 "이런 경우가 드물다"고 했죠? 진심이에요. INTJ가 먼저 다음을 묻는 건 사실상 고백이에요 🔍',
      Ending.friend: '서로를 알아본 두 사람. 다만 둘 다 신중해서 진도가 느릴 뿐이에요. 먼저 연락해봐요.',
      Ending.fail: '비슷한 사람끼리 오히려 거리 조절에 실패했어요. 같은 유형이라도 표현은 필요해요.',
    },
  ),
};

final episode2 = BlindDate(
  id: 'date02',
  character: seoyun,
  turns: seoyunTurns,
  openingScript: seoyunOpeningScript,
  closingScripts: seoyunClosingScripts,
  styleInfo: seoyunStyleInfoMap,
);
