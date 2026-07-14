import '../models/models.dart';
import 'episode16_script.dart';

export 'episode16_script.dart';

/// 16화 ENTJ 태린 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode16_script.dart 참고.

const taerin = TDCharacter(
  id: 'date16_taerin',
  name: '태린',
  age: 30,
  job: '스타트업 대표',
  location: '서울',
  mbti: 'ENTJ',
  intro: '시간은 아껴 써도, 진심은 아껴 쓰지 않아요',
  tags: ['#새벽수영', '#위스키', '#체스', '#야경', '#스타트업'],
  isUnlocked: true,
);

/// 16화(태린) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> taerinStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '태린의 빠른 템포에 밀리지 않고, 야경 뒤에 숨은 마음까지 밝게 읽어냈어요.',
    badPoint: '태린은 감탄보다 관찰을 좋아해요. 리액션에 구체적인 근거를 한 줄 얹어보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '태린의 에너지를 받아칠 수 있는 몇 안 되는 유형. 다만 태린의 서랍은 조용히 열어야 해요.',
    endingMessages: {
      Ending.success: '태린이 가짜 일정 문자를 세 번이나 씹게 만들었네요. 대표의 캘린더를 이긴 건 당신이 처음이에요 🌟',
      Ending.friend: '태린에게 즐거운 사람으로 남았어요. 근데 태린의 인생 계획표에 칸이 생겼다는 건, 아직 끝이 아니라는 뜻일지도요.',
      Ending.fail: '밝은 에너지가 태린에게는 가끔 인터뷰처럼 느껴졌을 수 있어요. 다음엔 감탄 대신 질문을 건네보세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '태린의 언어로 대화했어요. 복기, 역산, 정확한 피드백. 태린이 제일 편해하는 문법이에요.',
    badPoint: '둘 다 결론이 빠른 타입이라, 태린이 서랍을 여는 순간엔 결론을 잠깐 꺼두는 연습이 필요해요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '전략 회의는 완벽한데, 연애에는 퇴근이 필요해요. 둘 다 퇴근을 못 하는 게 이 조합의 함정.',
    endingMessages: {
      Ending.success: '대표 대 대표의 협상이 아니라, 사람 대 사람의 대화가 됐어요. 태린의 다음 계약서엔 퇴근 조항이 생겼습니다 ⚡',
      Ending.friend: '최고의 스파링 파트너로 남았어요. 태린이 자문을 구하는 사람은 많아도, 지는 얘기를 웃으며 하는 상대는 드물어요.',
      Ending.fail: '직진과 직진이 같은 차선에서 만났네요. 태린 같은 상대에겐 속도보다 방향을 먼저 맞춰야 해요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '주차장의 한 시간, 명함 없는 태린. 아무도 못 본 장면들을 정확히 알아봐준 유일한 유형이에요.',
    badPoint: '태린의 속도에 끌려가지 말고, 당신의 템포로 멈춰 세워도 돼요. 태린은 그 순간을 오히려 고마워해요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '태린에게 필요한 건 또 한 명의 참모가 아니라, 물 밖에서도 숨 쉴 수 있는 자리예요. 그걸 줄 수 있는 유형.',
    endingMessages: {
      Ending.success: '태린이 무섭다는 말을 처음 소리 내서 한 상대가 당신이에요. 대표의 마음속 이사회에 만장일치가 나왔습니다 🌙',
      Ending.friend: '태린이 편하게 숨 쉬는 사람이 됐어요. 여기서 마음을 한 번만 먼저 표현하면, 관계의 직함이 바뀔 수 있어요.',
      Ending.fail: '깊은 마음이 표현 앞에서 머뭇거렸어요. 태린은 보이지 않는 마음은 없는 것으로 결재하는 사람이에요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '말수는 적지만 문장마다 밀도가 높아서, 태린이 받아 적고 싶어 하는 말을 여러 번 남겼어요.',
    badPoint: '분석이 정확할수록 태린은 마음도 궁금해해요. 결론 뒤에 감정을 한 문장만 붙여보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '태린은 말이 많은 사람보다 말이 남는 사람을 좋아해요. 조용한 정확함, 대표의 취향 저격.',
    endingMessages: {
      Ending.success: '"만든 사람이 만들어진 것보다 크다" 같은 문장을 남기는 사람, 태린이 놓칠 리 없죠. 다음 약속은 이미 확정입니다 🔍',
      Ending.friend: '태린의 신뢰 리스트 최상단에 올랐어요. 여기서 딱 한 걸음, 정확한 관찰 대신 솔직한 마음이면 돼요.',
      Ending.fail: '신중함이 태린에게는 유보로 읽혔을 수 있어요. 태린은 확신을 보여주는 사람에게만 서랍을 열어요.',
    },
  ),
};

final episode16 = BlindDate(
  id: 'date16',
  character: taerin,
  turns: taerinTurns,
  openingScript: taerinOpeningScript,
  closingScripts: taerinClosingScripts,
  styleInfo: taerinStyleInfoMap,
);
