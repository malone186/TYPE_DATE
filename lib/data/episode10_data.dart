import '../models/models.dart';
import 'episode10_script.dart';

export 'episode10_script.dart';

/// 10화 ESFJ 민지 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode10_script.dart 참고.

const minji = TDCharacter(
  id: 'date10_minji',
  name: '민지',
  age: 26,
  job: '초등학교 교사',
  location: '서울',
  mbti: 'ESFJ',
  intro: '챙기는 게 특기예요. 근데 오늘은 저도 좀 챙겨줘요',
  tags: ['#우리반', '#홈베이킹', '#생일요정', '#다이어리', '#파스타'],
  isUnlocked: true,
);

/// 10화(민지) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> minjiStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '민지의 밝은 텐션을 같은 온도로 받아주면서, 챙기기만 하던 민지가 처음으로 챙김받는 기분을 느끼게 했어요.',
    badPoint: '둘 다 상대 기분부터 살피는 타입이라, 가끔은 리액션 대신 솔직한 속마음을 먼저 꺼내보세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '표현의 속도와 온도가 똑같아요. 민지가 "나 좋아하는 거 맞지?"를 물어볼 필요가 없는 유일한 조합.',
    endingMessages: {
      Ending.success: '따뜻함은 따뜻함을 알아봐요. 잘되면 주려고 스콘을 챙겨온 사람에게, 이미 답은 정해져 있었어요 🌟',
      Ending.friend: '대화 내내 웃음이 끊기지 않았지만 설렘까지는 못 갔어요. 대신 스콘 시식단 자격은 평생 유효할 듯!',
      Ending.fail: '리액션만으로는 민지의 불안이 안 풀려요. 다음엔 공감에 "다음 약속 날짜"를 붙여보세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '밤 11시 학부모 전화에 "안 받아도 된다"는 방패를 건네고, 티라미수 예약까지 먼저 가져갔어요. 늘 주기만 하던 민지에게는 신선한 충격.',
    badPoint: '민지의 고민에 정리·해결책부터 꺼내면 마음이 닫혀요. 결론 전에 "괜찮아요?" 한마디를 먼저요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '민지가 하던 예약과 챙김을 대신 해주는 든든한 조합. 감정 얘기에서 속도만 줄이면 완성돼요.',
    endingMessages: {
      Ending.success: '민지 인생 처음으로 받는 쪽이 되는 연애가 시작될 것 같아요. 일요일 티라미수 예약, 잊지 마세요 ⚡',
      Ending.friend: '든든한 사람으로는 확실히 각인됐어요. 민지의 다이어리에 이름은 올라갔으니 절반은 성공.',
      Ending.fail: '"정리가 답"류의 해결책이 민지에게는 계산으로 들렸을 수 있어요. 민지의 사람들은 거르는 대상이 아니거든요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '안 좋아하는 빵을 매주 굽는다는 말 뒤에 숨은 마음을 알아보고 "민지 씨 몫은 어디 있어요?"를 물을 수 있는 건 이 유형뿐이에요.',
    badPoint: '민지는 말로 못 들으면 백 가지 상상을 하는 사람이에요. 마음이 커질수록 말을 아끼면 민지는 불안해져요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '깊이는 통하는데 표현 빈도가 달라요. 민지가 자꾸 확인 질문을 하게 되는, 연습이 필요한 조합.',
    endingMessages: {
      Ending.success: '조용한 사람이 건넨 한 번의 질문이 민지의 반성회를 자랑회로 바꿨어요. 깊이로 이긴 소개팅 🌙',
      Ending.friend: '민지가 속 얘기를 꺼낸 몇 안 되는 사람이 됐어요. 표현 한 스푼만 더하면 다음 장이 열려요.',
      Ending.fail: '아낀 말들이 민지에게는 빈칸으로 남았어요. 이 사람 앞에서는 오글거림 반 스푼이 예의예요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '말수는 적어도 한 말은 지키는 사람이라는 인상을 줬어요. "확인 안 해도 되는 사람"은 민지가 제일 오래 기다린 안정감이에요.',
    badPoint: '민지의 하루는 리액션으로 굴러가요. 팩트 정리 사이사이에 감탄사 하나씩만 끼워 넣어보세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '민지의 불안을 잠재우는 묵직한 신뢰형. 다만 민지의 수다에 답장 속도가 못 따라갈 수 있어요.',
    endingMessages: {
      Ending.success: '"대화 지분 6 대 4" 같은 정확한 말이 민지에게는 어떤 꽃다발보다 로맨틱했어요. 반성회 기각 🔍',
      Ending.friend: '믿을 수 있는 사람으로 남았어요. 민지에게는 여기서 표현 한 걸음이 관계를 바꿔요.',
      Ending.fail: '신중함이 민지에게는 "언제 한번" 같은 보류로 읽혔을 수 있어요. 확인이 필요한 사람에게는 확실한 말이 먼저예요.',
    },
  ),
};

final episode10 = BlindDate(
  id: 'date10',
  character: minji,
  turns: minjiTurns,
  openingScript: minjiOpeningScript,
  closingScripts: minjiClosingScripts,
  styleInfo: minjiStyleInfoMap,
);
