import '../models/models.dart';
import 'episode6_script.dart';

export 'episode6_script.dart';

/// 6화 ESTP 세진 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode6_script.dart 참고.

const sejin = TDCharacter(
  id: 'date06_sejin',
  name: '세진',
  age: 27,
  job: '서핑샵 운영',
  location: '양양',
  mbti: 'ESTP',
  intro: '고민할 시간에 일단 부딪혀보는 편이에요. 물은 들어가봐야 알거든요',
  tags: ['#서핑', '#스노보드', '#새벽라이딩', '#캠핑', '#즉흥여행'],
  isUnlocked: true,
);

/// 6화(세진) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> sejinStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🔥',
    title: '텐션 만렙 파도메이트',
    summary: '에너지가 넘치고 따뜻해요. 같이 놀 줄 아는 타입.',
    goodPoint: '세진의 속도를 그대로 받아치면서, 겨울 바다 얘기가 나온 순간엔 텐션을 내리고 마음을 알아봐줬어요.',
    badPoint: '세진은 눈치가 빨라서 과한 리액션은 빈말로 읽어요. 감탄은 구체적으로 해주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '속도도 온도도 다 맞아요. 세진이 브레이크 없이 직진하고 싶어지는 상대예요.',
    endingMessages: {
      Ending.success: '같이 달리고, 멈춰야 할 순간엔 같이 멈췄어요. 세진이 막차 시간을 검색하게 만든 사람, 흔치 않아요 🔥',
      Ending.friend: '최고의 놀이 메이트로 남았어요. 근데 세진은 잘 노는 사람에게 약하니까, 다음 파도는 또 와요.',
      Ending.fail: '텐션은 맞았는데 진심이 늦게 탔어요. 세진은 신나는 사람이 아니라 알아봐주는 사람을 기다리고 있었거든요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '🏄',
    title: '거침없는 스피드러',
    summary: '적극적이고 명쾌해요. 속도로 승부하는 타입.',
    goodPoint: '세진의 빠른 템포에 한 박자도 밀리지 않고, 즉흥 제안에 그 자리에서 답을 줬어요.',
    badPoint: '세진이 처음으로 약한 얘기를 꺼낼 때는 해결책보다 그냥 들어주는 게 정답이에요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '노는 합은 완벽한 조합. 다만 세진의 조용한 순간을 놓치면 딱 한 뼘이 안 좁혀져요.',
    endingMessages: {
      Ending.success: '결정 빠른 사람은 결정 빠른 사람을 알아봐요. 다음 주 양양행, 이미 확정이나 다름없죠 🏄',
      Ending.friend: '세진에게 최고의 대화 상대로 남았어요. 겨울 바다 얘기에 한 발 더 들어갔다면 결과가 달랐을지도요.',
      Ending.fail: '속도 경쟁이 됐을 수 있어요. 세진은 같이 달릴 사람보다, 달리다 멈춰도 되는 사람을 찾고 있었어요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌊',
    title: '잔잔한 파도 관측자',
    summary: '조용하지만 깊게 봐요. 마음을 알아채는 타입.',
    goodPoint: '세진의 씩씩한 사장님 역할 뒤에 있는 진짜 마음을, 아무도 못 본 그 마음을 알아봤어요.',
    badPoint: '세진은 몸으로 노는 사람이라, 마음만큼 몸도 한 번씩 움직여주면 거리가 확 줄어요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '속도 차이는 분명 있어요. 대신 세진의 겨울 바다를 알아보는 건 이 유형이 제일 빨라요.',
    endingMessages: {
      Ending.success: '속도가 아니라 깊이로 잡은 파도예요. 세진이 바람 핑계를 못 댄 날, 기억해두세요 🌊',
      Ending.friend: '세진에게 유일하게 조용한 얘기를 할 수 있는 사람이 됐어요. 그거, 생각보다 큰 자리예요.',
      Ending.fail: '세진의 파도를 관측만 하다 끝났을 수 있어요. 이 사람 앞에서는 일단 물에 들어가야 해요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🧭',
    title: '신중한 항로 설계자',
    summary: '말수는 적고 판단은 정확해요. 재고 움직이는 타입.',
    goodPoint: '즉흥이 아니라 결정이 빠른 사람이라는 것, 세진을 가장 정확하게 읽어낸 건 이 유형이에요.',
    badPoint: '세진에게 검토와 보류는 거절로 들려요. 판단이 섰으면 그 자리에서 말해주세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '파도는 오는 순간 잡아야 한다는 사람과 예보부터 보는 사람. 서로에게 제일 낯선 조합이에요.',
    endingMessages: {
      Ending.success: '신중한 사람의 확신은 무게가 달라요. 세진도 그걸 알아서, 이 성공은 꽤 단단할 거예요 🧭',
      Ending.friend: '신뢰는 얻었는데 파도는 못 탔어요. 세진과는 계산이 끝나기 전에 몸이 먼저 나가야 해요.',
      Ending.fail: '데이터가 하루치뿐이라는 말, 세진에게는 보류가 아니라 거절로 들렸을 거예요. 파도는 기다려주지 않거든요.',
    },
  ),
};

final episode6 = BlindDate(
  id: 'date06',
  character: sejin,
  turns: sejinTurns,
  openingScript: sejinOpeningScript,
  closingScripts: sejinClosingScripts,
  styleInfo: sejinStyleInfoMap,
);
