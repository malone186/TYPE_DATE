import '../models/models.dart';
import 'episode5_script.dart';

export 'episode5_script.dart';

/// 5화 INFP 다은 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode5_script.dart 참고.

const daeun = TDCharacter(
  id: 'date05_daeun',
  name: '다은',
  age: 27,
  job: '출판사 편집자',
  location: '서울',
  mbti: 'INFP',
  intro: '말수는 적은데, 좋아하는 얘기가 나오면 문장이 길어져요',
  tags: ['#독립서점', '#필사노트', '#재독파', '#골목산책', '#서랍속소설'],
  isUnlocked: true,
);

/// 5화(다은) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> daeunStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '다은의 조심스러운 문장들을 밝게 받아주면서 마음의 문을 생각보다 빨리 열게 했어요.',
    badPoint: '다은은 높은 텐션의 리액션보다 천천히 곱씹어주는 대화에서 마음이 깊어져요. 가끔은 반 박자 늦춰보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '온도는 잘 맞는데 속도가 달라요. 다은의 속도에 맞춰 걸을 수만 있다면 아주 따뜻해지는 조합.',
    endingMessages: {
      Ending.success: '밝은 온기가 다은의 서랍을 열었어요. 다은이 책을 빌려줬다면, 그건 마음을 맡겼다는 뜻이에요 🌟',
      Ending.friend: '다은에게 즐거운 사람으로 남았어요. 서랍 속 얘기까지 듣는 사이가 되려면 반 박자의 기다림이 더 필요해요.',
      Ending.fail: '높은 텐션이 다은에게는 조금 눈부셨을 수 있어요. 다음엔 말수를 줄이고 질문을 늘려보세요!',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '명확한 화법으로 다은의 꿈을 뜬구름이 아니라 실현 가능한 계획으로 대해줬어요.',
    badPoint: '다은의 고민에 해결책부터 내밀면 마음이 닫혀요. 답을 말하기 전에 온도를 먼저 맞춰보세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '화법의 온도차가 큰 조합. 대신 다은의 꿈을 진지하게 계산해주는 순간, 다른 유형은 못 주는 신뢰를 줄 수 있어요.',
    endingMessages: {
      Ending.success: '직진이 통했다기보다, 다은의 꿈을 숫자로 존중해준 게 통했어요. 이 조합에서는 흔치 않은 승리예요 ⚡',
      Ending.friend: '똑똑한 대화 상대로는 확실히 인정받았어요. 근데 다은의 마음은 논리 바깥에서 움직여요. 거기까지 가려면 다른 언어가 필요해요.',
      Ending.fail: '맞는 말이 다은에게는 차가운 말로 들렸을 수 있어요. 이 유형에게는 정답보다 온도가 먼저예요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '다은의 미완성된 문장 뒤에 있는 마음까지 읽어줬어요. 서랍 속 소설 얘기를 꺼내게 하는 건 이 유형뿐이에요.',
    badPoint: '둘 다 말을 아끼는 타입이라 대화가 고요 속에 멈출 수 있어요. 가끔은 먼저 문을 두드려주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '같은 문법을 쓰는 두 사람. 다은이 제일 편안해지는 조합이에요. 누가 먼저 용기를 내느냐만 남았어요.',
    endingMessages: {
      Ending.success: '조용한 사람들의 대화가 제일 깊다는 걸 증명했어요. 다은의 소설 첫 독자 자리, 예약 완료예요 🌙',
      Ending.friend: '마음은 통했는데 둘 다 반 발짝을 안 내디뎠어요. 이 관계는 먼저 문을 두드리는 쪽이 이겨요.',
      Ending.fail: '조심스러움이 겹쳐서 서로의 마음을 확인하지 못했을 수 있어요. 다은에게는 조용해도 분명한 표현이 필요해요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '차분한 관찰과 정확한 말로 다은에게 재촉하지 않고 기다려주는 사람이라는 안정감을 줬어요.',
    badPoint: '다은은 감정을 분석당한다고 느끼면 숨어요. 관찰의 결과를 가끔은 감탄으로 바꿔 말해보세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '다은의 속도를 재촉하지 않는 드문 유형. 신뢰는 깊게 쌓이는데, 설렘 스위치는 결국 표현에서 눌려요.',
    endingMessages: {
      Ending.success: '조용한 확신이 다은의 불안을 이겼어요. 말수가 적어도 마음이 정확한 사람, 다은의 취향이에요 🔍',
      Ending.friend: '편안하고 믿을 만한 사람으로 남았어요. 여기서 한 문장의 표현만 더하면 다음 장으로 넘어가요.',
      Ending.fail: '신중함이 다은에게는 거리감으로 읽혔을 수 있어요. 조용한 사람들끼리는 누군가 먼저 마음을 소리 내야 해요.',
    },
  ),
};

final episode5 = BlindDate(
  id: 'date05',
  character: daeun,
  turns: daeunTurns,
  openingScript: daeunOpeningScript,
  closingScripts: daeunClosingScripts,
  styleInfo: daeunStyleInfoMap,
);
