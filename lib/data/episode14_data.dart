import '../models/models.dart';
import 'episode14_script.dart';

export 'episode14_script.dart';

/// 14화 ESFP 유나 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode14_script.dart 참고.

const yuna = TDCharacter(
  id: 'date14_yuna',
  name: '유나',
  age: 25,
  job: '뮤지컬 배우',
  location: '서울',
  mbti: 'ESFP',
  intro: '텐션을 무대에 두고 오는 법을 아직 못 배웠어요',
  tags: ['#뮤지컬', '#커튼콜', '#즉흥여행', '#사람관찰', '#대학로단골펍'],
  isUnlocked: true,
);

/// 14화(유나) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> yunaStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '유나의 텐션을 같은 온도로 받아치면서, 그 밝음이 배려라는 것까지 알아봐줬어요.',
    badPoint: '둘 다 액셀만 밟는 조합이라, 유나가 커튼콜 뒤 이야기를 꺼낼 땐 잠깐 볼륨을 줄여주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '떨림을 연료로 쓰는 사람과 그 연료에 불을 붙이는 사람. 유나가 즉흥 바다행을 제안하고 싶어지는 상대예요.',
    endingMessages: {
      Ending.success: '무대 밖에서 심쿵한 건 데뷔 이래 처음이래요. 금요일 밤공연 초대권, 이미 이름 적혀 있을걸요? 🌟',
      Ending.friend: '텐션 합은 완벽했지만 설렘 조명까지는 안 켜졌어요. 대신 월요일 남의 공연 동행 자리는 예약된 것 같은데요?',
      Ending.fail: '밝음과 밝음이 만나면 가끔 서로의 그늘을 놓쳐요. 유나가 조용해지는 순간이 사실 제일 큰 신호였어요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '커튼콜의 짜릿함을 아는 야망으로, 유나와 "이름을 건다"는 말이 통하는 대화를 만들었어요.',
    badPoint: '유나의 떨림과 즉흥은 관리 대상이 아니에요. 로드맵을 꺼내는 순간 유나는 현실 세계로 소환돼버려요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '에너지 속도는 잘 맞는데, 유나의 세계를 계산서로 번역하는 순간 온도가 뚝 떨어지는 조합이에요.',
    endingMessages: {
      Ending.success: '같은 야망을 알아본 두 사람. 유나 심장 박자가 빨라진 건 무대 때문이 아니었어요 ⚡',
      Ending.friend: '멋있는 사람으로는 확실하게 남았어요. 다만 유나에게 필요한 건 해결책보다 객석의 박수였을지도요.',
      Ending.fail: '플랜B, 페이스 조절, 온도 계산... 다 맞는 말인데, 유나에게는 맞는 말이라서 더 힘든 말이었어요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '박수가 꺼진 뒤의 조용한 밤거리까지 헤아려줬어요. 유나가 "견뎌왔다"는 말에 울컥한 이유예요.',
    badPoint: '유나는 좋으면 팔 붙잡고 "저거 봐!!" 해야 하는 사람이에요. 마음을 안에만 두면 옆자리가 비어 보여요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '객석 어딘가에서 자기를 알아봐주는 눈, 배우에게 제일 큰 선물이죠. 표현 속도만 반 박자 올리면 돼요.',
    endingMessages: {
      Ending.success: '제일 밝은 사람의 제일 어두운 시간을 알아본 사람. 유나가 커튼콜보다 오래 기억할 관객이 됐어요 🌙',
      Ending.friend: '유나에게 조용히 기대도 되는 사람으로 남았어요. 여기서 표현 한 걸음이면 무대가 바뀔 수 있어요.',
      Ending.fail: '유나의 텐션에 방전 걱정부터 앞섰던 것 같아요. 그 밝음이 사실 배려였다는 걸 조금 늦게 알았죠.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '"성실하게 밝은 사람"처럼 유나를 정확한 언어로 읽어냈어요. 관찰당하는 걸 좋아하는 배우에게는 새로운 종류의 박수였죠.',
    badPoint: '분석이 채점처럼 들리는 순간 유나는 무대 인사 모드로 돌아가요. 정확함에 온기를 한 스푼 얹어보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '유나는 시끄럽다는 말만 듣던 사람이라, 자기를 제대로 읽어주는 조용한 눈에 완전히 무장해제돼요.',
    endingMessages: {
      Ending.success: '"완전 졌다"는 말, 유나 입에서 나오기 쉽지 않아요. 관찰력으로 이긴 소개팅이에요 🔍',
      Ending.friend: '유나의 숨은그림찾기 포스터는 못 찾았지만, 신뢰는 확실히 찾았어요. 다음은 표현 차례예요.',
      Ending.fail: '신중함이 유나에게는 "올 듯 말 듯한 관객"처럼 읽혔을 수 있어요. 배우에게는 확답이 제일 큰 응원이에요.',
    },
  ),
};

final episode14 = BlindDate(
  id: 'date14',
  character: yuna,
  turns: yunaTurns,
  openingScript: yunaOpeningScript,
  closingScripts: yunaClosingScripts,
  styleInfo: yunaStyleInfoMap,
);
