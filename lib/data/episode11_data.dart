import '../models/models.dart';
import 'episode11_script.dart';

export 'episode11_script.dart';

/// 11화 INTP 연우 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode11_script.dart 참고.

const yeonwoo = TDCharacter(
  id: 'date11_yeonwoo',
  name: '연우',
  age: 28,
  job: 'AI 연구원',
  location: '서울',
  mbti: 'INTP',
  intro: '말이 없는 게 아니라, 고르고 있는 거예요',
  tags: ['#보드게임', '#AI연구', '#SF소설', '#새벽코딩', '#아이스아메리카노'],
  isUnlocked: true,
);

/// 11화(연우) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> yeonwooStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '연우의 어색한 침묵을 밝은 에너지로 채우고, 무표정 뒤의 표정을 알아봐줬어요.',
    badPoint: '연우에게 높은 텐션은 가끔 과부하예요. 리액션을 반 박자 줄이고 질문을 하나 더 얹어보세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '온도는 좋은데 전압이 달라요. 연우의 배터리가 먼저 닳을 수 있는 조합이에요.',
    endingMessages: {
      Ending.success: '연우의 냉각 장치를 꺼버린 사람이 됐어요. 발화량 상위 5%는 아무나 만드는 기록이 아니에요 🌟',
      Ending.friend: '연우도 즐거웠지만 방전이 조금 빨랐어요. 대신 보드게임 모임 초대장은 진심이에요.',
      Ending.fail: '밝은 에너지가 연우에게는 해석 불가 신호였을 수 있어요. 다음엔 텐션 대신 궁금증으로 다가가보세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '전력으로 승부하고 전략을 논하는 태도가 연우의 게임 본능을 깨웠어요.',
    badPoint: '연우는 결론보다 과정의 "왜"를 사랑해요. 답을 내리기 전에 같이 헤매주는 시간도 필요해요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '토론 상대로는 최고의 합. 다만 속도전보다 사고의 산책을 원할 때가 있어요.',
    endingMessages: {
      Ending.success: '노이즈 주입 전략까지 제안하는 상대라니, 연우 입장에선 채택 안 할 이유가 없죠 ⚡',
      Ending.friend: '최고의 게임 파트너로 등록됐어요. 여기서 마음 얘기 한 스푼이면 관계가 바뀔 수 있어요.',
      Ending.fail: '결론이 빠른 대화가 연우에게는 문이 닫히는 소리로 들렸을 수 있어요. 질문을 남겨두는 여백이 필요해요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '연우가 처음으로 "무섭다"고 말한 순간, 고치려 들지 않고 그대로 들어줬어요.',
    badPoint: '연우는 표정 데이터를 잘 못 읽어요. 느낀 마음은 언어로 직접 송신해야 확실하게 도착해요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '침묵이 어색하지 않은 조합. 연우의 무표정 뒤 표정을 읽는 몇 안 되는 유형이에요.',
    endingMessages: {
      Ending.success: '연우에게 "표정이 많은 사람"이라는 걸 알려준 첫 사람이 됐어요. 그 기록은 안 지워져요 🌙',
      Ending.friend: '연우의 신뢰 목록에 올랐어요. 마음이 있다면 관측값 말고 감정값도 말해주세요.',
      Ending.fail: '서로 조용히 기다리다 신호가 소멸했을 수 있어요. 연우에게는 먼저 보내는 한 문장이 필요해요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '시뮬레이터의 "결과"를 물어봐준 사람. 연우의 언어를 통역 없이 알아들었어요.',
    badPoint: '둘 다 마음을 데이터 뒤에 숨기는 타입이에요. 가끔은 검증 전의 감정도 말해보세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '주파수가 같은 조합. 연우가 "동일한 결과가 나왔어요"라고 말하게 되는 상대예요.',
    endingMessages: {
      Ending.success: '오차범위 없이 통했어요. 연우의 소개팅 표본에서 20%를 뚫은 건 당신이 처음일지도요 🔍',
      Ending.friend: '대화 밀도는 최상급이었어요. 다음 단계로 가려면 관측값에 마음을 한 줄 추가하세요.',
      Ending.fail: '논리는 통했는데 신호 송신이 부족했어요. 연우는 표정을 못 읽어요. 말로 해야 도착해요.',
    },
  ),
};

final episode11 = BlindDate(
  id: 'date11',
  character: yeonwoo,
  turns: yeonwooTurns,
  openingScript: yeonwooOpeningScript,
  closingScripts: yeonwooClosingScripts,
  styleInfo: yeonwooStyleInfoMap,
);
