import '../models/models.dart';
import 'episode12_script.dart';

export 'episode12_script.dart';

/// 12화 ENFJ 하은 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode12_script.dart 참고.

const haeun = TDCharacter(
  id: 'date12_haeun',
  name: '하은',
  age: 29,
  job: '강연 기획자',
  location: '서울',
  mbti: 'ENFJ',
  intro: '질문이 많은 편이에요. 대신 끝까지 들어요',
  tags: ['#강연기획', '#문장수집가', '#식탁회담', '#노을맛집', '#질문부자'],
  isUnlocked: true,
);

/// 12화(하은) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> haeunStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '하은의 식탁회담, 큐시트 뒤에서 흘린 눈물 같은 이야기에 같은 온도로 반응하며 "결이 비슷하다"는 말을 끌어냈어요.',
    badPoint: '둘 다 주는 게 익숙한 호스트 타입이라, 서로 챙기다가 정작 하은의 이야기가 묻힐 수 있어요. 가끔은 리액션을 멈추고 질문을 던져보세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '온기는 확실히 통하는 조합. 다만 무대를 만드는 사람이 둘이면, 객석에 앉을 사람이 없어요.',
    endingMessages: {
      Ending.success: '따뜻함으로 하은의 인터뷰 모드를 무장해제시켰어요. 노을 핑계 대고 눈가 훔친 거, 아무한테나 보여주는 장면 아니에요 🌟',
      Ending.friend: '하은에게 최고의 대화 상대로 남았어요. 다음 식탁회담 명단에 이름이 올라갔다면, 그건 하은식 애정 표현이에요.',
      Ending.fail: '밝은 리액션만으로는 하은의 지난 소개팅들과 다르지 않았어요. 하은에게 필요한 건 박수가 아니라 질문이에요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '"언제 시작할 거예요?" 같은 데드라인 질문으로 하은의 꿈 "첫 문장"에 시동을 걸었어요. 기획자는 그런 질문에 약해요.',
    badPoint: '하은이 조심스럽게 꺼낸 속마음에 해결책이나 평가부터 얹으면 하은은 다시 인터뷰어로 숨어버려요. 결론을 반 박자만 늦춰보세요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '추진력은 좋지만 둘 다 앞에서 끄는 스타일이라, 하은이 결국 맞춰주는 역할로 돌아가기 쉬운 조합이에요.',
    endingMessages: {
      Ending.success: '정확한 칭찬이 제일 오래 남는다는 하은의 말, 기억하죠? 그 정확함으로 하은의 방어를 뚫었어요 ⚡',
      Ending.friend: '대화의 합은 좋았지만 하은은 끝내 자기 얘기를 아꼈어요. 능력자끼리의 즐거운 미팅, 딱 거기까지였어요.',
      Ending.fail: '하은에게는 진단과 조언이 아니라 "당신 얘기가 듣고 싶다"는 말이 필요했어요. 구조 분석은 정확했지만, 타이밍이 아니었네요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '현관에 가만히 앉아 있는 시간을 "회복"이라 불러주고, 노트 첫 페이지의 문장을 조르지 않고 기다려줬어요. 하은이 스물아홉 해 동안 기다린 사람이에요.',
    badPoint: '하은은 표현이 큰 사람이라, 마음을 너무 아껴두면 하은 혼자 확신 없이 기다리게 돼요. 느껴진 건 말로도 한 번씩 건네주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '무대를 만들어주기만 하던 하은에게 처음으로 객석을 내어주는 조합. 하은의 아홉 권째 노트는 이 유형의 문장으로 채워질 거예요.',
    endingMessages: {
      Ending.success: '조용한 질문 하나로 에너자이저의 대본 없는 얼굴을 꺼냈어요. 노트 첫 페이지 문장을 먼저 보여준 사람, 당신이 처음이에요 🌙',
      Ending.friend: '하은에게 세상에서 제일 편한 인터뷰이가 됐어요. 여기서 마음 한 줄만 소리 내어 읽으면, 관계의 페이지가 넘어가요.',
      Ending.fail: '깊이는 있었지만 신호가 너무 희미했어요. 늘 먼저 다가가던 하은도, 이번엔 다가와주는 사람을 기다리고 있었거든요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '"감동은 설계된 것"이라는 하은의 직업 세계를 정확히 읽고, "하은 씨가 원하는 건 누가 봐줘요?"라는 한 방의 질문으로 하은을 멈춰 세웠어요.',
    badPoint: '관찰이 진단으로 넘어가는 순간 하은은 움츠러들어요. 번아웃 같은 단어 대신, 본 것을 그대로 말해주는 쪽이 하은에게는 위로예요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '말은 적어도 질문이 정확한 사람. 인터뷰만 하던 하은이 처음으로 답하는 쪽에 서고 싶어지는 조합이에요.',
    endingMessages: {
      Ending.success: '"자기 얘기할 때 세 배쯤 반짝였다"는 관찰, 하은은 반박하지 못했어요. 정확한 사람이 정성까지 있으면 이렇게 이깁니다 🔍',
      Ending.friend: '하은에게 신뢰할 수 있는 관찰자로 남았어요. 다음엔 관찰 말고 마음을 한 줄 보태보세요. 하은은 그 한 줄을 기다려요.',
      Ending.fail: '분석은 맞았지만 하은이 원한 건 정답이 아니라 곁이었어요. 좋은 질문은 사람을 살리고, 이른 진단은 사람을 닫게 해요.',
    },
  ),
};

final episode12 = BlindDate(
  id: 'date12',
  character: haeun,
  turns: haeunTurns,
  openingScript: haeunOpeningScript,
  closingScripts: haeunClosingScripts,
  styleInfo: haeunStyleInfoMap,
);
