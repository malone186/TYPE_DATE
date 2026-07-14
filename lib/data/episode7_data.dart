import '../models/models.dart';
import 'episode7_script.dart';

export 'episode7_script.dart';

/// 7화 ISFJ 수민 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode7_script.dart 참고.

const sumin = TDCharacter(
  id: 'date07_sumin',
  name: '수민',
  age: 27,
  job: '간호사',
  location: '서울',
  mbti: 'ISFJ',
  intro: '기억력이 좋아요. 특히 사람에 대한 건요',
  tags: ['#3교대생존러', '#디저트오픈런', '#홈베이킹', '#식물집사', '#손편지'],
  isUnlocked: true,
);

/// 7화(수민) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> suminStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '수민이 감춰둔 마음을 밝은 온기로 먼저 두드려서, 늘 듣기만 하던 사람이 자기 얘기를 하게 만들었어요.',
    badPoint: '수민은 따뜻한 표현을 좋아하지만 소화하는 데 시간이 걸려요. 훅 들어간 다음엔 한 박자 기다려주세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '주기만 하던 사람에게 필요한 건 잘 받는 사람이 아니라 되돌려주는 사람이에요. 수민이 처음으로 받는 연습을 하게 되는 조합.',
    endingMessages: {
      Ending.success: '따뜻한 직진이 수민의 빗장을 열었어요. 몰래 포장한 케이크, 그거 수민식 고백이에요 🌟',
      Ending.friend: '수민에게 세상 편한 사람이 됐어요. 편안함에서 설렘까지는 딱 한 걸음, 다음엔 그 걸음을 먼저 내디뎌보세요.',
      Ending.fail: '밝은 에너지가 수민에게는 가끔 속도위반으로 느껴졌을 수 있어요. 이 사람 앞에서는 반 박자만 느리게!',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '수민이 혼자 끌어안고 있던 고민들을 명쾌한 한마디로 정리해줄 때마다, 수민이 놀란 눈으로 웃었어요.',
    badPoint: '수민에게 해결책은 늘 두 번째예요. 정답을 말하기 전에 마음부터 읽어주는 순서 연습이 필요해요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '속도와 온도가 다른 조합. 수민은 정답을 주는 사람보다 곁을 지켜주는 사람에게 마음을 열어요.',
    endingMessages: {
      Ending.success: '직진에도 온도를 담을 수 있다는 걸 증명했네요. 수민이 오프 스케줄을 제일 먼저 알려주는 사람, 그게 당신이에요 ⚡',
      Ending.friend: '수민에게 든든한 사람으로 남았어요. 다음엔 결론 대신 "괜찮아요?" 한마디를 먼저 건네보세요.',
      Ending.fail: '명쾌한 화법이 수민에게는 가끔 처방전처럼 들렸을 수 있어요. 이 사람에게는 답보다 귀가 먼저예요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '조용한 사람들끼리만 아는 신호를 정확히 읽었어요. 수민이 말을 삼키는 순간마다 먼저 알아채고 물어봐줬죠.',
    badPoint: '둘 다 먼저 말하길 기다리다 연락이 멈출 수 있는 조합이에요. 표현만큼은 용기를 내보세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '깊이는 최고, 속도는 최저인 조합. 누가 먼저 한 걸음만 떼면 제일 오래가는 커플이 돼요.',
    endingMessages: {
      Ending.success: '말수가 아니라 온도로 통한 소개팅. 수민이 화분 이름을 다 알려준 사람은 당신이 처음일 거예요 🌙',
      Ending.friend: '서로가 편한 침묵을 아는 사이가 됐어요. 이제 필요한 건 케이크 이모지 같은 둘만의 신호 하나예요.',
      Ending.fail: '마음은 닿았는데 표현이 반 발짝 늦었어요. 수민 같은 사람에게는 먼저 내미는 손이 절반이에요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '말수는 적어도 일관되고 정확한 태도가, 예측 가능한 사람에게 안심하는 수민에게 신뢰를 줬어요.',
    badPoint: '수민은 표현을 잘 못 하는 만큼 표현에 굶주려 있어요. 마음이 있다면 계산 말고 티를 내야 전달돼요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '둘 다 진국인데 둘 다 과묵한 조합. 신뢰는 빨리 쌓이는데 설렘은 천천히 와요.',
    endingMessages: {
      Ending.success: '조용한 확신이 통했어요. 요란한 이벤트보다 꾸준한 사람을 기다려온 수민에게 정답 같은 상대예요 🔍',
      Ending.friend: '신뢰는 확실하게 쌓였어요. 수민에게는 표현 한 스푼이면 관계의 온도가 바뀌어요.',
      Ending.fail: '신중함이 수민에게는 마음 없음으로 읽혔을 수 있어요. 기다리는 사람에게는 신호를 줘야 해요.',
    },
  ),
};

final episode7 = BlindDate(
  id: 'date07',
  character: sumin,
  turns: suminTurns,
  openingScript: suminOpeningScript,
  closingScripts: suminClosingScripts,
  styleInfo: suminStyleInfoMap,
);
