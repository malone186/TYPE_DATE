import '../models/models.dart';
import 'episode8_script.dart';

export 'episode8_script.dart';

/// 8화 ENTP 나래 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode8_script.dart 참고.

const narae = TDCharacter(
  id: 'date08_narae',
  name: '나래',
  age: 28,
  job: '스타트업 PM',
  location: '판교',
  mbti: 'ENTP',
  intro: '세상에서 제일 재미없는 말은 "원래 그래요"예요',
  tags: ['#사이드프로젝트', '#밸런스게임', '#수제버거', '#즉흥여행', '#토론환영'],
  isUnlocked: true,
);

/// 8화(나래) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> naraeStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '나래의 텐션을 같이 끌어올리면서도, 농담 뒤에 숨은 진심까지 놓치지 않고 받아줬어요.',
    badPoint: '나래는 리액션만큼 반박도 원해요. 가끔은 공감 대신 "그건 아니죠"로 맞받아쳐 보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '에너지 궁합은 최상급이에요. 여기에 티키타카 한 스푼만 더해지면 나래가 먼저 애프터를 겁니다.',
    endingMessages: {
      Ending.success: '나래의 금지어를 깨뜨린 건 화려한 말이 아니라 따뜻한 리액션이었어요. 새벽 수산시장 알람 맞춰두세요 🌟',
      Ending.friend: '나래에게 최고의 관객으로 남았어요. 다음엔 박수 대신 반박을 한번 던져보세요. 무대가 데이트로 바뀔 거예요.',
      Ending.fail: '리액션은 좋았는데 핑퐁이 안 됐던 것 같아요. 나래에게는 받아주는 사람보다 받아치는 사람이 필요해요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '나래의 "반박 환영"에 진짜 반박으로 답한 유일한 유형이에요. 나래가 제일 즐거워하는 대화를 만들었어요.',
    badPoint: '논쟁이 즐거워도 나래가 진지해지는 순간은 구분해주세요. 그때는 논리를 잠깐 내려놓아야 해요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '나래가 찾던 스파링 파트너예요. 속도, 유머, 논리 삼박자가 맞아서 대화가 끝나질 않는 조합.',
    endingMessages: {
      Ending.success: '아이디어에 혹평을 얹었는데 호감이 올라가는 상대, 나래뿐이에요. 이 티키타카는 놓치면 안 됩니다 ⚡',
      Ending.friend: '최고의 토론 상대로 등록됐어요. 나래의 다음 연락은 아이디어 자문일 텐데, 그 자리를 데이트로 바꾸는 건 표현이에요.',
      Ending.fail: '논쟁이 승부가 되어버린 것 같아요. 나래는 이기고 싶은 게 아니라 같이 놀고 싶었던 거예요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '번아웃 얘기도, 노션 리스트 얘기도 농담으로 흘리지 않았어요. 나래의 조용한 고백을 알아본 건 이 유형이에요.',
    badPoint: '나래의 말 속도에 침묵으로 답하면 오해가 생겨요. 서툴러도 계속 말을 얹어주세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '나래의 텐션에 기가 빨릴 수 있는 조합이에요. 대신 나래가 조용해지는 순간의 진심은 이 유형만 알아봐요.',
    endingMessages: {
      Ending.success: '속도가 아니라 깊이로 나래를 멈춰 세웠어요. 말문 막힌 나래, 아무나 볼 수 있는 장면이 아니에요 🌙',
      Ending.friend: '나래에게 "이상하게 편한 사람"으로 남았어요. 템포를 반 박자만 올리면 다음 장이 열려요.',
      Ending.fail: '나래의 말 폭풍 속에서 마음을 다 못 보여준 것 같아요. 이 사람 앞에서는 서툰 말이 침묵보다 나아요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '말수는 적어도 던질 때마다 정확한 반박이라, 나래가 "이 사람 한마디는 세 마디 값"이라고 느꼈어요.',
    badPoint: '나래는 결론만큼 과정의 수다를 좋아해요. 정답이 없어도 생각을 소리 내서 같이 굴려주세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '나래의 아이디어를 벼려주는 숫돌 같은 조합. 다만 나래의 에너지를 받아줄 체력이 관건이에요.',
    endingMessages: {
      Ending.success: '조용한 정확함이 나래의 호기심을 제대로 자극했어요. 나래가 궁금해하는 사람이 됐다는 건 이미 이긴 거예요 🔍',
      Ending.friend: '신뢰는 확실하게 쌓였어요. 나래에게는 여기서 농담 반 걸음, 표현 한 걸음이면 관계가 바뀌어요.',
      Ending.fail: '신중함이 나래에게는 미지근함으로 읽혔을 수 있어요. 이 사람 앞에서는 완성 안 된 생각도 꺼내는 게 매력이에요.',
    },
  ),
};

final episode8 = BlindDate(
  id: 'date08',
  character: narae,
  turns: naraeTurns,
  openingScript: naraeOpeningScript,
  closingScripts: naraeClosingScripts,
  styleInfo: naraeStyleInfoMap,
);
