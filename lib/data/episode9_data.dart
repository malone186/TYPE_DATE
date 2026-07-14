import '../models/models.dart';
import 'episode9_script.dart';

export 'episode9_script.dart';

/// 9화 ISTP 주하 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode9_script.dart 참고.

const juha = TDCharacter(
  id: 'date09_juha',
  name: '주하',
  age: 28,
  job: '자동차 R&D 엔지니어',
  location: '수원',
  mbti: 'ISTP',
  intro: '말은 아끼는 편인데, 마음은 행동으로 나가요',
  tags: ['#드립커피', '#홈로스팅', '#올드카복원', '#라이딩', '#과묵'],
  isUnlocked: true,
);

/// 9화(주하) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> juhaStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '말이 느린 주하를 재촉하지 않고, 밝은 에너지로 조수석 검증 지원까지 자연스럽게 따냈어요.',
    badPoint: '주하에게 침묵은 어색함이 아니라 쉼표예요. 빈틈을 아무 말로 채우려는 순간 온도가 내려가요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '에너지 총량이 달라요. 주하의 방전 속도를 못 읽으면, 노래방 데려가자다 정차 신호를 놓치는 조합.',
    endingMessages: {
      Ending.success: '조용한 사람 옆에서 볼륨을 줄일 줄 아는 밝음이었어요. 주하가 아무나 안 태우는 조수석, 그거 예약된 거예요 🌟',
      Ending.friend: '주하도 즐거웠지만 배터리가 먼저 닳았어요. 대신 로스터 완성되면 원두 받는 사이는 됐네요.',
      Ending.fail: '침묵을 채우려는 배려가 주하에게는 소음으로 들렸을 수 있어요. 이 사람 옆에서는 가끔 같이 조용해져 보세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '조건은 명확하게, 요구는 사양서처럼. 주하가 제일 반가워하는 방식으로 대화를 끌고 갔어요.',
    badPoint: '주하의 감정은 계기판에 잘 안 떠요. 결론으로 달리기 전에 무덤덤한 얼굴 뒤를 한 번 물어봐 주세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '회의 합은 최고예요. 다만 주하의 마음은 협상 테이블이 아니라 엔진룸에 있어서, 속도만으로는 못 열어요.',
    endingMessages: {
      Ending.success: '애매한 서운함 대신 명확한 요구. 주하가 만들 수 있는 주문서를 내민 게 이겼어요. 코스 확정 연락, 곧 와요 ⚡',
      Ending.friend: '대화 품질은 검수 통과였는데 설렘 수치가 안 찍혔어요. 이런 관계는 의외로 오래 굴러갑니다.',
      Ending.fail: '템포가 너무 빨랐어요. 주하는 생각하고 말하는 사람이라, 재촉당하면 아예 시동을 꺼버려요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '차 소리로 안부를 읽던 사람에게 "그것도 표현이었다"고 말해줬어요. 주하의 3년 묵은 말을 꺼낸 것도 이 유형이에요.',
    badPoint: '주하는 빈말에 경고등이 켜지는 사람이에요. 마음이 정해졌으면 돌리지 말고 정확하게 말해주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '말수는 둘 다 적은데 전달량은 제일 많은 조합. 주하의 무덤덤한 계기판을 유일하게 판독하는 유형이에요.',
    endingMessages: {
      Ending.success: '자리 잡아둔 것, 커피 골라준 것까지 다 세고 있던 사람. 주하 계기판에 수치 높게 찍힌 거, 흔한 일 아니에요 🌙',
      Ending.friend: '깊이는 통했는데 스파크가 안 튀었어요. 주하에게 조용한 옆자리로 남는 것도 꽤 귀한 자리예요.',
      Ending.fail: '마음이 있었어도 신호가 너무 약했을 수 있어요. 과묵한 사람 둘 사이에는 누군가 한 번은 먼저 켜야 해요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '분쇄도 질문부터 배기 라인 사진까지, 주하가 눈 안 풀리고 듣는 사람 처음 봤다고 할 만한 대화였어요.',
    badPoint: '통하는 만큼 표현은 서로 미루게 돼요. 약 봉투 같은 행동 신호를 가끔은 말로도 번역해 주세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '침묵도 대화가 되는 조합. 각자 풀고 개운한 얼굴로 만나는 방식이 설명 없이 통해요.',
    endingMessages: {
      Ending.success: '불량 문장 출고 안 하는 사람끼리 만났네요. 주하가 먼저 다음 코스 도면을 그리는 상대, 흔치 않아요 🔍',
      Ending.friend: '신뢰 검증은 끝났어요. 여기서 마음 한 줄만 말로 출고하면 관계 등급이 바뀝니다.',
      Ending.fail: '신중함이 주하에게는 보류로 읽혔을 수 있어요. 생각해볼게요, 는 이 사람에게 제일 애매한 답이에요.',
    },
  ),
};

final episode9 = BlindDate(
  id: 'date09',
  character: juha,
  turns: juhaTurns,
  openingScript: juhaOpeningScript,
  closingScripts: juhaClosingScripts,
  styleInfo: juhaStyleInfoMap,
);
