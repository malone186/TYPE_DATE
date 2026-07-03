import '../models/models.dart';
import 'episode1_script.dart';

export 'episode1_script.dart';

/// PRD v1.2 §7 콘텐츠 명세 — 1화 ENFP 지수
/// 대사·연출 대본은 episode1_script.dart 참고.

const jisu = TDCharacter(
  id: 'date01_jisu',
  name: '지수',
  age: 26,
  job: '콘텐츠 기획자',
  location: '인천',
  mbti: 'ENFP',
  intro: '아이디어는 넘치는데 마감은 항상 빠듯해요 🔥 퇴근하면 딴 사람 됩니다',
  tags: ['#필름카메라', '#즉흥여행', '#카페투어', '#플리마켓', '#맛집탐방'],
  isUnlocked: true,
  imagePath: 'assets/images/jisu.png',
);

/// 16개 캐릭터 슬롯 — 1화(지수)만 해금, 나머지는 잠금 placeholder
final List<TDCharacter> allCharacterSlots = [
  jisu,
  const TDCharacter(
    id: 'date02_intj',
    name: '???',
    age: 0,
    job: '',
    location: '',
    mbti: 'INTJ',
    intro: '차갑다는 말 많이 들어요. 근데 사실 그게 싫어요',
    tags: [],
    isUnlocked: false,
  ),
  for (int i = 3; i <= 16; i++)
    TDCharacter(
      id: 'date${i.toString().padLeft(2, '0')}',
      name: '???',
      age: 0,
      job: '',
      location: '',
      mbti: '????',
      intro: '',
      tags: const [],
      isUnlocked: false,
    ),
];

final episode1 = BlindDate(
  id: 'date01',
  character: jisu,
  turns: jisuTurns,
  openingScript: jisuOpeningScript,
);

/// 8-2 유형별 보고서 텍스트
final Map<String, StyleInfo> styleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '상대방 감정에 자연스럽게 공감하고 분위기를 따뜻하게 만들었어요.',
    badPoint: '때로는 현실적인 시각도 매력이 될 수 있어요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '감성 코드가 딱 맞아요. 최고의 궁합.',
    endingMessages: {
      Ending.success: '공감 능력이 지수의 마음을 완전히 열었어요. 다음 연락은 지수가 먼저 할 것 같은데요? 😊',
      Ending.friend: '대화는 잘 통했지만 설렘보다는 편안함. 좋은 인연으로 이어질 수 있어요.',
      Ending.fail: '에너지는 맞았지만 타이밍이 아니었던 것 같아요. 15명 더 있잖아요 💪',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '에너지 넘치는 현실주의자',
    summary: '활발하지만 논리적이에요. 대화를 주도하는 타입.',
    goodPoint: '대화를 적극적으로 이끌고 현실적인 조언을 자신 있게 전달했어요.',
    badPoint: '상대방 감정에 먼저 공감해주면 더 가까워질 수 있어요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '에너지는 통하지만 감성 코드에서 온도 차이가 있어요.',
    endingMessages: {
      Ending.success: '적극적인 태도가 지수의 눈에 들었어요! 활발한 케미, 다음이 기대되네요.',
      Ending.friend: '활발한 대화는 좋았지만 감성적인 부분에서 약간 온도 차이가 있었어요.',
      Ending.fail: '논리적인 답변이 ENFP한테는 조금 차갑게 느껴졌을 수 있어요. 다음엔 공감 먼저!',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '상대방 말을 잘 들어주고 깊은 공감을 섬세하게 표현했어요.',
    badPoint: '조금 더 먼저 나서면 상대방이 훨씬 편하게 느낄 수 있어요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '공감대는 있지만 에너지 차이가 있어요. 서로 보완되는 관계.',
    endingMessages: {
      Ending.success: '조용한 매력이 지수의 호기심을 자극했어요. 궁금한 사람으로 기억될 것 같아요 🌙',
      Ending.friend: '따뜻한 리스너로 좋은 인상을 남겼어요. 친구로 시작해도 충분히 발전할 수 있어요.',
      Ending.fail: '조금 더 적극적으로 나섰다면 어땠을까요? 다음 소개팅에서 꼭 시도해봐요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '차분한 분석가',
    summary: '신중하고 이성적이에요. 조용히 관찰하는 타입.',
    goodPoint: '상황을 차분하게 파악하고 신중하게 대화를 이어갔어요.',
    badPoint: 'ENFP에게는 감성적인 반응이 더 잘 통해요. 공감을 먼저 표현해봐요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '성격 차이가 있지만 서로 배울 점이 많아요.',
    endingMessages: {
      Ending.success: '의외의 케미! 차분한 매력이 활발한 지수에게 신선하게 느껴졌을 거예요 🔍',
      Ending.friend: '가치관 차이가 있지만 오히려 대화가 풍부해지는 관계예요.',
      Ending.fail: 'ENFP와는 감성 코드 차이가 컸어요. 다른 유형에서 딱 맞는 사람을 만날 수 있어요.',
    },
  ),
};
