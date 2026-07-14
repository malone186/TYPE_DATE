import '../models/models.dart';
import 'episode15_script.dart';

export 'episode15_script.dart';

/// 15화 INFJ 지원 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode15_script.dart 참고.

const jiwon = TDCharacter(
  id: 'date15_jiwon',
  name: '지원',
  age: 28,
  job: '심리상담사',
  location: '서울',
  mbti: 'INFJ',
  intro: '말보다 마음을 먼저 듣는 편이에요. 대신 한번 연 마음은 깊어요',
  tags: ['#차', '#필사', '#추리소설', '#골목산책', '#일요일은혼자'],
  isUnlocked: true,
);

/// 15화(지원) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> jiwonStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '늘 듣기만 하던 지원에게 먼저 다가가 말할 자리를 만들어줬어요. 지원의 침묵을 어색해하지 않은 것도 컸어요.',
    badPoint: '지원은 텐션보다 온도에 반응해요. 리액션을 반 박자 줄이고 여백을 견디면 대화가 더 깊어져요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '지원의 조용한 호수에 돌을 던져 물결을 만들어주는 조합. 속도만 맞추면 서로에게 없는 걸 채워줘요.',
    endingMessages: {
      Ending.success: '밝은 에너지가 지원의 닫힌 문을 두드렸어요. 지원이 자기 얘기를 먼저 꺼냈다면, 그건 이미 특별하다는 뜻이에요 🌟',
      Ending.friend: '지원에게 편하고 즐거운 사람으로 남았어요. 다만 지원의 깊은 방까지는 아직 초대받지 못했네요.',
      Ending.fail: '지원에게는 큰 목소리보다 낮은 목소리가 더 크게 들려요. 다음엔 말수 대신 질문의 깊이를 채워보세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '지원이 생각에 잠길 때 명확한 말로 안개를 걷어줬어요. "오해는 확인 안 해서 생기는 거"라는 태도가 지원에게 안정감을 줬어요.',
    badPoint: '지원의 은유와 침묵에는 결론이 없어요. 답을 내리기 전에 세 박자만 기다려주면 훨씬 잘 통해요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '속도 차이가 큰 조합. 지원은 세 번은 우려야 우러나는 사람이라, 첫 잔에서 판단하면 서로를 놓쳐요.',
    endingMessages: {
      Ending.success: '속도를 늦추고 기다릴 줄 아는 직진이었어요. 지원이 느린 말로 마음을 꺼냈다면 완승이에요 ⚡',
      Ending.friend: '신뢰는 얻었지만 지원의 마음은 아직 첫 우림이에요. 조급해하지 않으면 다음 잔이 있어요.',
      Ending.fail: '명확함이 지원에게는 재촉으로 들렸을 수 있어요. 이 사람에게 필요한 건 답이 아니라 시간이에요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '"오늘은 제가 들을게요"라는 태도로, 평생 듣는 자리에만 있던 지원을 말하는 자리에 앉혀줬어요.',
    badPoint: '둘 다 마음을 늦게 여는 타입이라, 가끔은 먼저 문을 열어 보여줘야 관계가 앞으로 가요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '침묵이 어색하지 않은 유일한 조합. 지원이 "이 사람 앞에서는 쉬어진다"고 느끼는 상대예요.',
    endingMessages: {
      Ending.success: '깊이가 깊이를 알아봤어요. 지원이 필사 노트의 문장을 읽어주는 사이, 흔치 않아요 🌙',
      Ending.friend: '결이 같아서 편했지만, 둘 다 신호를 기다리기만 했네요. 다음엔 반 걸음만 먼저 다가가 보세요.',
      Ending.fail: '조용함과 조용함이 만나 침묵이 길어졌을 수 있어요. 지원은 마음을 읽는 사람이지만, 독심술사는 아니에요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '"끝이 보인다"는 지원의 불안을 "그건 예측일 뿐"이라고 정확하게 뒤집어줬어요. 지원이 오래 곱씹을 말이에요.',
    badPoint: '지원은 분석당하는 데 지친 사람이기도 해요. 가끔은 정리 대신 마음을 그대로 보여주세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '조용한 깊이는 통하는데 언어가 달라요. 지원은 은유로 말하고 이 유형은 정의로 말하죠. 번역만 되면 오래가요.',
    endingMessages: {
      Ending.success: '차분한 논리가 지원의 생각 많은 밤을 가볍게 해줬어요. 지원에게 이런 사람은 처음이었을 거예요 🔍',
      Ending.friend: '지원이 믿을 만한 사람이라고 느꼈어요. 여기서 마음 표현 한 스푼이면 다음 잔으로 넘어가요.',
      Ending.fail: '정확한 말이 지원에게는 상담실 언어처럼 들렸을 수 있어요. 지원이 원한 건 진단이 아니라 온기였어요.',
    },
  ),
};

final episode15 = BlindDate(
  id: 'date15',
  character: jiwon,
  turns: jiwonTurns,
  openingScript: jiwonOpeningScript,
  closingScripts: jiwonClosingScripts,
  styleInfo: jiwonStyleInfoMap,
);
